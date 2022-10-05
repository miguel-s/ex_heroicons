if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Phxicons.LiveView do
    @moduledoc """
    A LiveView component for rendering Phxicons.

    ## Examples

        <Phxicons.LiveView.icon name="AiFillAccountBook" class="h-4 w-4" />
    """

    use Phoenix.Component

    def icon(assigns) do
      class_opts = class_to_opts(assigns)

      size = assigns[:size] || "1em"

      opts = (assigns[:opts] || [])
        |> Keyword.merge([
          width: size,
          height: size
        ])
        |> Keyword.merge(class_opts)

      assigns = assign(assigns, opts: opts)

      ~H"""
      <%= Phxicons.icon(@name, @opts) %>
      """
    end

    defp class_to_opts(assigns) do
      if assigns[:class] do
        [class: assigns.class]
      else
        []
      end
    end
  end
end
