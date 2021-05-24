defmodule Heroicons do
  @moduledoc """
  This package adds a convenient way of using [Heroicons](https://heroicons.com/) with your Phoenix, Phoenix LiveView and Surface applications.

  Heroicons is "A set of 450+ free MIT-licensed high-quality SVG icons for you to use in your web projects."
  Created by the amazing folks at [Tailwind Labs](https://github.com/tailwindlabs).

  You can find the original docs [here](https://heroicons.com) and repo [here](https://github.com/tailwindlabs/heroicons).

  ## Installation

  Add `ex_heroicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_heroicons, "~> 0.1.0"}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

  ### With Eex or Leex

      <%= Heroicons.icon("outline", "academic-cap", class: "h-4 w-4") %>

  ### With Surface

      <Heroicons.Components.Icon type="outline" name="academic-cap" class="h-4 w-4" />
  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/heroicons/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  @doc """
  Generates an icon.

  ## Options

    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("outline", "academic-cap", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path d="M12 14l9-5-9-5-9 5 9 5z"/>
            <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222"/>
          </svg>
  """
  def icon(type, name, opts \\ [])

  for %{type: type, name: name, contents: contents} <- icons do
    def icon(unquote(type), unquote(name), opts) do
      unquote(contents)
    end
  end

  def icon(type, name, _opts) do
    raise ArgumentError,
          "icon of type #{inspect(type)} with name #{inspect(name)} does not exist."
  end
end
