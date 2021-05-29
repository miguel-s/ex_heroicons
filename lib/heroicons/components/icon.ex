if Code.ensure_loaded?(Surface) do
  defmodule Heroicons.Components.Icon do
    @moduledoc """
    A Surface component for rendering Heroicons.

    ## Examples

        <Heroicons.Components.Icon type="outline" name="academic-cap" class="h-4 w-4" />
    """

    use Surface.Component

    @doc "The type of the icon"
    prop type, :string, values: ["outline", "solid"], required: true

    @doc "The name of the icon"
    prop name, :string, required: true

    @doc "The class of the icon"
    prop class, :css_class

    @doc "All options are forwarded to the underlying SVG tag as HTML attributes"
    prop opts, :keyword, default: []

    def render(assigns) do
      opts = class_to_opts(assigns) ++ assigns.opts

      ~H"""
      {{ Heroicons.icon(@type, @name, opts) }}
      """
    end

    defp class_to_opts(assigns) do
      case Map.get(assigns, :class) do
        nil -> []
        class -> [class: Surface.css_class(class)]
      end
    end
  end
end
