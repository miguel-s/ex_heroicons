defmodule Heroicons do
  @moduledoc """
  Documentation for `Heroicons`.
  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/heroicons/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

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
