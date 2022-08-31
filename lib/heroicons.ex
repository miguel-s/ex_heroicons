defmodule Heroicons do
  @moduledoc """
  This package adds a convenient way of using [Heroicons](https://heroicons.com) with your Phoenix, Phoenix LiveView and Surface applications.

  Heroicons is "A set of 450+ free MIT-licensed high-quality SVG icons for you to use in your web projects."
  Created by the amazing folks at [Tailwind Labs](https://github.com/tailwindlabs).

  You can find the original docs [here](https://heroicons.com) and repo [here](https://github.com/tailwindlabs/heroicons).

  ## Installation

  Add `ex_heroicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_heroicons, "~> 0.6.1"}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

  #### With Eex or Leex

      <%= Heroicons.icon("academic-cap", type: "outline", class: "h-4 w-4") %>

  #### With Heex

      <Heroicons.LiveView.icon name="academic-cap" type="outline" class="h-4 w-4" />

  #### With Surface

      <Heroicons.Surface.Icon name="academic-cap" type="outline" class="h-4 w-4" />

  ## Config

  Defaults can be set in the `Heroicons` application configuration.

      config :ex_heroicons, type: "outline"
  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/heroicons/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  types = icons |> Enum.map(& &1.type) |> Enum.uniq()
  names = icons |> Enum.map(& &1.name) |> Enum.uniq()

  @types types
  @names names

  @doc "Returns a list of available icon types"
  @spec types() :: [String.t()]
  def types(), do: @types

  @doc "Returns a list of available icon names"
  @spec names() :: [String.t()]
  def names(), do: @names

  @doc false
  def default_type() do
    case Application.get_env(:ex_heroicons, :type) do
      nil ->
        nil

      type when is_binary(type) ->
        if type in types() do
          type
        else
          raise ArgumentError,
                "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
        end

      type ->
        raise ArgumentError,
              "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end
  end

  @doc """
  Generates an icon.

  Options may be passed through to the SVG tag for custom attributes.

  ## Options

    * `:type` - the icon type. Accepted values are #{inspect(types)}. Required if default type is not configured.
    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("academic-cap", type: "outline", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path d="M12 14l9-5-9-5-9 5 9 5z"/>
            <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222"/>
          </svg>
  """
  @spec icon(String.t(), keyword) :: Phoenix.HTML.safe()
  def icon(name, opts \\ []) when is_binary(name) and is_list(opts) do
    {type, opts} = Keyword.pop(opts, :type, default_type())

    unless type do
      raise ArgumentError,
            "expected type in options, got: #{inspect(opts)}"
    end

    unless type in types() do
      raise ArgumentError,
            "expected type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end

    icon(type, name, opts)
  end

  for %Icon{type: type, name: name, file: file} <- icons do
    defp icon(unquote(type), unquote(name), opts) do
      attrs = Icon.opts_to_attrs(opts)
      Icon.insert_attrs(unquote(file), attrs)
    end
  end

  defp icon(type, name, _opts) do
    raise ArgumentError,
          "icon #{inspect(name)} with type #{inspect(type)} does not exist."
  end
end
