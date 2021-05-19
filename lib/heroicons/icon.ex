defmodule Heroicons.Icon do
  defstruct [:type, :name, :contents]

  def parse!(filename) do
    [type, name] = filename |> Path.split() |> Enum.take(-2)

    name = Path.rootname(name)

    options = [
      engine: Phoenix.HTML.Engine,
      line: 1,
      indentation: 0
    ]

    contents =
      filename
      |> File.read!()
      |> String.replace("<svg", ~s(<svg class="<%= opts[:class] %>"))
      |> EEx.compile_string(options)

    struct!(__MODULE__, type: type, name: name, contents: contents)
  end
end
