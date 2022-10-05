defmodule Phxicons do
  @moduledoc """
  This package adds a convenient way of using [React Icons](https://react-icons.github.io/react-icons) with your Phoenix, Phoenix LiveView and Surface applications.

  Phxicons is "A set of popular high-quality SVG icons for you to use in your web projects."

  Icons are taken from other projects
  so please check each project licences accordingly.

  ## Installation

  Add `elixircl_phxicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:elixircl_phxicons, "~> 1.0.0"}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

  #### With Eex or Leex

      <%= Phxicons.icon("AiFillAccountBook", class: "h-4 w-4") %>

  #### With Heex

      <Phxicons.LiveView.icon name="AiFillAccountBook" class="h-4 w-4" />

  #### With Surface

      <Phxicons.Surface.Icon name="AiFillAccountBook" class="h-4 w-4" />
  """

  alias __MODULE__.Icon

  @icons %{}
  @cwd File.cwd!()

  @doc "Returns a list of available icon names"
  @spec names() :: [String.t()]
  def names(), do: Map.keys(@icons)

  @doc """
  Generates an icon.

  Options may be passed through to the SVG tag for custom attributes.

  ## Options

    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("AiFillAccountBook", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path d="M12 14l9-5-9-5-9 5 9 5z"/>
            <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222"/>
          </svg>
  """
  @spec icon(String.t(), keyword) :: Phoenix.HTML.safe()
  def icon(name, opts \\ []) do

    options = [
      stroke: "currentColor",
      fill: "currentColor",
      "stroke-width": "0",
      width: "1em",
      height: "1em"
      ]
      |> Keyword.merge(opts)
    # We have to read from disk, it adds more compilation
    # time if we preload it beforehand
    icon = case Map.get(@icons, name) do
      nil ->  Path.relative_to_cwd("#{@cwd}/icons/#{name}.svg")
              |> Icon.parse!()
      icon -> icon
    end

    @icons = Map.put(@icons, name, icon)

    attrs = Icon.opts_to_attrs(options)
    Icon.insert_attrs(icon.file, attrs)
  end
end
