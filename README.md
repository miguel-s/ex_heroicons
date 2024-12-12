# Heroicons

![CI](https://github.com/miguel-s/ex_heroicons/actions/workflows/ci.yml/badge.svg)

This package adds a convenient way of using [Heroicons](https://heroicons.com) with your Phoenix, Phoenix LiveView and Surface applications.

Heroicons is "A set of 450+ free MIT-licensed high-quality SVG icons for you to use in your web projects."
Created by the amazing folks at [Tailwind Labs](https://github.com/tailwindlabs).

You can find the original docs [here](https://heroicons.com) and repo [here](https://github.com/tailwindlabs/heroicons).

## Installation

Add `ex_heroicons` and `heroicons` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_heroicons, "~> 3.1.0"},
    {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.5",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1}
  ]
end
```

Then run `mix deps.get`.

## Usage

```elixir
<Heroicons.icon name="academic-cap" type="outline" class="h-4 w-4" />
```

## Config

Defaults can be set in the `Heroicons` application configuration.

```elixir
config :ex_heroicons, type: "outline"
```

## License

MIT. See [LICENSE](https://github.com/miguel-s/ex_heroicons/blob/master/LICENSE) for more details.
