# Heroicons

![CI](https://github.com/miguel-s/ex_heroicons/actions/workflows/ci.yml/badge.svg)

This package adds a convenient way of using [Heroicons](https://heroicons.com) with your Phoenix, Phoenix LiveView and Surface applications.

Heroicons is "A set of 450+ free MIT-licensed high-quality SVG icons for you to use in your web projects."
Created by the amazing folks at [Tailwind Labs](https://github.com/tailwindlabs).

You can find the original docs [here](https://heroicons.com) and repo [here](https://github.com/tailwindlabs/heroicons).

## Installation

Add `ex_heroicons` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_heroicons, "~> 0.1.4"}
  ]
end
```

Then run `mix deps.get`.

## Usage

### With Eex or Leex

```elixir
<%= Heroicons.icon("outline", "academic-cap", class: "h-4 w-4") %>
```

### With Surface

```elixir
<Heroicons.Components.Icon type="outline" name="academic-cap" class="h-4 w-4" />
```
