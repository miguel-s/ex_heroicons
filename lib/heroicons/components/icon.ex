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

    def render(assigns) do
      opts =
        case Map.get(assigns, :class) do
          nil -> []
          class -> [class: Surface.css_class(class)]
        end

      ~H"""
      {{ Heroicons.icon(@type, @name, opts) }}
      """
    end
  end
end
