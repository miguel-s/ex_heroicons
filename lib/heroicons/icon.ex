defmodule Heroicons.Icon do
  @moduledoc """
  This module defines the data structure and functions for working with icons stored as SVG files.
  """

  defstruct [:type, :name, :contents]

  @doc "Parses a SVG file and returns structured data"
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
