if Code.ensure_loaded?(Surface) do
  defmodule Heroicons.Components.Icon do
    @moduledoc """
    A Surface component for rendering Heroicons.

    ## Examples

        <Heroicons.Components.Icon name="academic-cap" type="outline" class="h-4 w-4" />
    """

    use Surface.Component

    @doc "The name of the icon"
    prop name, :string, required: true

    @doc """
    The type of the icon

    Required if default type is not configured.
    """
    prop type, :string

    @doc "The class of the icon"
    prop class, :css_class

    @doc "All options are forwarded to the underlying SVG tag as HTML attributes"
    prop opts, :keyword, default: []

    def render(assigns) do
      ~F"""
      {Heroicons.icon(@name, type_to_opts(@type) ++ class_to_opts(@class) ++ @opts)}
      """
    end

    defp type_to_opts(type) do
      type = type || Heroicons.default_type()

      unless type do
        raise ArgumentError,
              "type prop is required if default type is not configured."
      end

      [type: type]
    end

    defp class_to_opts(class) do
      if class do
        [class: Surface.css_class(class)]
      else
        []
      end
    end
  end
end
