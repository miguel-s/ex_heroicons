#!/usr/bin/env python3
import json
import os

class Icon:

    def __init__(self, data, root):
        self.name = data["name"]
        self.root = root
        self.file = self.name + ".svg"
        self.dir = data["dir"]
        self.data = data["data"]
        self.meta = data["meta"]
        self.path = os.path.join(self.root)
        self.filepath = os.path.join(self.path, self.file)
        self.content = self.make_content()

    def make_svg_body(self, data):
        body = ""

        for item in data:
            if item["tag"] == "title" or item["tag"] == "desc":
                # avoid clutter tags in some svg
                continue

            body = body + f"""<{item["tag"]} """
            for key, value in item["attr"].items():
                body = body + f"""{key}="{value}" """
            
            if item.get("child", None):
                body = body.strip() + ">" + self.make_svg_body(item["child"]) + f"""</{item["tag"]}>\n"""
            else:
                body = body.strip() + "/>\n"

        return body.strip()

    def make_svg_attrs(self, content):
        attrs = ""
        for key, value in self.data["attr"].items():
            attrs = attrs + f"""{key}="{value}" """

        return content.replace("%attrs%", attrs.strip())

    def make_meta(self, content):
        return content.replace("%meta%", f"""<!--
[file]
name: "{self.name}"
file: "{self.file}"
origin: "{self.meta["svg"]}"

[group]
id: "{self.meta["group"]["id"]}"
name: "{self.meta["group"]["name"]}"
url: "{self.meta["group"]["url"]}"

[license]
name: "{self.meta["group"]["license"]["name"]}"
url: "{self.meta["group"]["license"].get("url", "")}"
-->""")

    def make_content(self):
        # add %meta%\n if you want each icon to have additional info
        content = """<svg xmlns="http://www.w3.org/2000/svg" %attrs%>\n%body%\n</svg>"""
        content = self.make_meta(content)
        content = self.make_svg_attrs(content)
        content = content.replace("%body%", self.make_svg_body(self.data["child"]))
        return content

    def save(self):
        out = open(self.filepath, "w")
        out.write(self.content)
        out.close()

def main():
    icons_json = json.loads(open(os.path.join("scripts", "icons.json")).read())
    root = "icons"

    try:
        os.mkdir(root)
    except OSError as error:
        pass

    for data in icons_json:
        icon = Icon(data, root)
        icon.save()
        

if __name__ == "__main__":
    main()
