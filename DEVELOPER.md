# Developer Docs

For building `icons.json` you would need the [react-icons](https://github.com/react-icons/react-icons) repo and install the dependencies.

```sh
$ git clone https://github.com/react-icons/react-icons
$ cd react-icons
$ yarn
$ yarn submodule
$ cd packages/react-icons
```

replace `scripts/task_files.js` contents with the following:

```js
const path = require("path");
const fs = require("fs").promises;
const fsSync = require("fs");

const camelcase = require("camelcase");

const { icons } = require("../src/icons");

const { iconRowTemplate } = require("./templates");
const { getIconFiles, convertIconData, rmDirRecursive } = require("./logics");
const { svgo } = require("./svgo");

async function dirInit({ DIST, LIB, rootDir }) {
  const ignore = (err) => {
    if (err.code === "EEXIST") return;
    throw err;
  };

  await rmDirRecursive(DIST).catch((err) => {
    if (err.code === "ENOENT") return;
    throw err;
  });
  await fs.mkdir(DIST, { recursive: true }).catch(ignore);
  await fs.mkdir(LIB).catch(ignore);
  await fs.mkdir(path.resolve(LIB, "esm")).catch(ignore);
  await fs.mkdir(path.resolve(LIB, "cjs")).catch(ignore);

  const write = (filePath, str) =>
    fs.writeFile(path.resolve(DIST, ...filePath), str, "utf8").catch(ignore);

  const initFiles = ["index.d.ts", "index.esm.js", "index.js"];

  for (const icon of icons) {
    await fs.mkdir(path.resolve(DIST, icon.id)).catch(ignore);
  }

  for (const file of initFiles) {
    await write([file], "// THIS FILE IS AUTO GENERATED\n");
  }
}
async function writeIconModuleFiles(icon, { DIST, LIB, rootDir }) {
  const exists = new Set(); // for remove duplicate

  const stream = fsSync.createWriteStream(path.resolve(DIST, `icons.json`), {flags:'a', encoding:"utf8"});
  
  for (const content of icon.contents) {
    const files = await getIconFiles(content);

    for (const file of files) {
      const svgStrRaw = await fs.readFile(file, "utf8");
      const svgStr = content.processWithSVGO
        ? await svgo.optimize(svgStrRaw).then((result) => result.data)
        : svgStrRaw;

      const iconData = await convertIconData(svgStr, content.multiColor);

      const rawName = path.basename(file, path.extname(file));
      const pascalName = camelcase(rawName, { pascalCase: true });
      const name =
        (content.formatter && content.formatter(pascalName, file)) ||
        pascalName;
      if (exists.has(name)) continue;
      exists.add(name);

      const jsonRes = {
        name,
        file: `${name}.json`,
        dir: icon.id,
        data: iconData,
        meta: {
          svg: path.basename(file),
          group: {
            name: icon.name,
            id: icon.id,
            url: icon.projectUrl,
            license: {
              name: icon.license,
              url: icon.licenseUrl
            }
          }
        }
      };

      stream.write(JSON.stringify(jsonRes));
      stream.write(",\n");
      exists.add(file);
    }
  }
}

module.exports = {
  dirInit,
  writeIconModuleFiles,
};

```

Finally you would get the json by executing the command

```sh
$ yarn build
```

It needs a small fix, just delete the last comma
and add square brackets, so it a json valid file.

```text
[ // add as the first char
    {} // json objects
    // delete last comma
] // add as the last char
```

You would find the file at `_react-icons_all-files/icons.json`.
Must copy the files the proper directory:

- `_react-icons_all-files/icons.json`
- `react-icons/VERSIONS`

## Compilation

When you got `icons.json` file in scripts directory, then you must execute

```sh
$ python3 scripts/make.py
``` 

to render the final files.
