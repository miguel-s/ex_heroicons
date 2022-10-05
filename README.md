# [Elixir Chile's Phxicons](https://github.com/elixircl/phxicons)

![CI](https://github.com/elixircl/phxicons/actions/workflows/ci.yml/badge.svg)

This package adds a convenient way of using [React Icons](https://react-icons.github.io/react-icons) with your Phoenix, Phoenix LiveView and Surface applications.

Phxicons is "A set of popular high-quality SVG icons for you to use in your web projects."

Icons are taken from the other projects
so please check each project licences accordingly.


## Installation

Add `elixircl_phxicons` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixircl_phxicons, "~> 1.0.0"}
  ]
end
```

Then run `mix deps.get`.

## Usage

#### With Eex or Leex

```elixir
<%= Phxicons.icon("AiFillAccountBook", class: "h-4 w-4") %>
```

#### With Heex

```elixir
<Phxicons.LiveView.icon name="AiFillAccountBook" class="h-4 w-4" />
```

#### With Surface

```elixir
<Phxicons.Surface.Icon name="AiFillAccountBook" class="h-4 w-4" />
```

## Preview
The preview site is the [`react-icons`](https://react-icons.github.io/react-icons) website, the file names are the same.

## License

MIT. See [LICENSE](https://github.com/elixircl/phxicons/blob/main/LICENSE) for more details.

## Thanks

Some portion of the code were based on the works of [@kamijin_fanta](https://github.com/react-icons/react-icons) and [@miguel-s](https://github.com/miguel-s/ex_heroicons).

## Credits

Made with <i class="fa fa-heart">&#9829;</i> by <a href="https://ninjas.cl" target="_blank">Ninjas.cl</a>.
