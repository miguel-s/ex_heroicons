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
          {:ex_heroicons, "~> 3.0.0"},
          {:heroicons,
            github: "tailwindlabs/heroicons",
            tag: "v2.1.5",
            sparse: "optimized",
            app: false,
            compile: false,
            depth: 1}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

      <Heroicons.icon name="academic-cap" type="outline" class="h-4 w-4" />

  ## Config

  Defaults can be set in the `Heroicons` application configuration.

      config :ex_heroicons, type: "outline"
  """

  use Phoenix.Component
  alias Heroicons.Icon

  heroicons_path =
    if File.exists?("deps/heroicons") do
      "deps/heroicons"
    else
      "../heroicons"
    end

  unless File.exists?(heroicons_path) do
    raise """
    Heroicons not found, please add the `heroicons` dependency to your project.

    Add `heroicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          ...,
          {:heroicons,
          github: "tailwindlabs/heroicons",
          tag: "v2.1.5",
          sparse: "optimized",
          app: false,
          compile: false,
          depth: 1}
        ]
      end
    """
  end

  icon_paths =
    heroicons_path
    |> Path.join("optimized/**/*.svg")
    |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  types = icons |> Enum.map(& &1.type) |> Enum.uniq()
  names = icons |> Enum.map(& &1.name) |> Enum.uniq()

  default_type =
    case Application.compile_env(:ex_heroicons, :type) do
      nil ->
        "outline"

      type when is_binary(type) ->
        if type in types do
          type
        else
          raise ArgumentError,
                "expected default type to be one of #{inspect(types)}, got: #{inspect(type)}"
        end

      type ->
        raise ArgumentError,
              "expected default type to be one of #{inspect(types)}, got: #{inspect(type)}"
    end

  @names names
  def names, do: @names

  @types types
  def types, do: @types

  attr :name, :string, values: @names, required: true, doc: "the name of the icon"
  attr :type, :string, values: @types, default: default_type, doc: "the type of the icon"
  attr :class, :string, default: nil, doc: "the css classes to add to the svg container"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the svg container"

  def icon(assigns) do
    name = assigns[:name]

    if name == nil or name not in @names do
      raise ArgumentError,
            "expected icon name to be one of #{inspect(unquote(@names))}, got: #{inspect(name)}"
    end

    type = assigns[:type]

    if type == nil or type not in @types do
      raise ArgumentError,
            "expected icon type to be one of #{inspect(unquote(@types))}, got: #{inspect(type)}"
    end

    ~H"""
    <!-- heroicons-<%= @type %>-<%= @name %> -->
    <.svg_container type={@type} class={@class} {@rest}>
      <%= {:safe, svg_body(@name, @type)} %>
    </.svg_container>
    """
  end

  attr :type, :string, values: @types, default: default_type, doc: "the type of the icon"
  attr :class, :string, default: nil, doc: "the css classes to add to the svg container"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the svg container"

  slot :inner_block, required: true, doc: "the svg paths to render inside the svg container"

  defp svg_container(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox={svg_viewbox(@type)}
      stroke-width="1.5"
      stroke="currentColor"
      aria-hidden="true"
      data-slot="icon"
      class={@class}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </svg>
    """
  end

  defp svg_viewbox(type) do
    case type do
      "micro" -> "0 0 16 16"
      "mini" -> "0 0 20 20"
      "solid" -> "0 0 24 24"
      "outline" -> "0 0 24 24"
    end
  end

  for %Icon{name: name, type: type, file: file} <- icons do
    defp svg_body(unquote(name), unquote(type)) do
      unquote(file)
    end
  end
end
