if Code.ensure_loaded?(Surface) do
  defmodule Phxicons.Surface.Icon do
    @moduledoc """
    A Surface component for rendering Phxicons.

    ## Examples

        <Phxicons.Surface.Icon name="AiFillAccountBook" class="h-4 w-4" />
    """

    use Surface.Component

    @doc "The name of the icon"
    prop name, :string, required: true

    @doc "The class of the icon"
    prop class, :css_class

    prop size, :string, default: "1em"

    @doc "All options are forwarded to the underlying SVG tag as HTML attributes"
    prop opts, :keyword, default: []

    def render(assigns) do
      class_opts = class_to_opts(assigns)

      opts = assigns.opts
        |> Keyword.merge([
          width: assigns.size,
          height: assigns.size
        ])
        |> Keyword.merge(class_opts)

      assigns = assign(assigns, opts: opts)

      ~F"""
      {Phxicons.icon(@name, @opts)}
      """
    end

    defp class_to_opts(assigns) do
      if assigns[:class] do
        [class: Surface.css_class(assigns.class)]
      else
        []
      end
    end
  end
end
