defmodule Heroicons.Icon do
  @moduledoc """
  This module defines the data structure and functions for working with icons stored as SVG files.
  """

  defstruct [:type, :name, :file]

  @doc "Parses a SVG file and returns structured data"
  def parse!(filename) do
    [type, name] = filename |> Path.split() |> Enum.take(-2)
    name = Path.rootname(name)
    file = File.read!(filename)
    struct!(__MODULE__, type: type, name: name, file: file)
  end

  @doc "Converts opts to HTML attributes"
  def opts_to_attrs(opts) do
    for {key, value} <- opts do
      key =
        key
        |> Atom.to_string()
        |> String.replace("_", "-")
        |> Phoenix.HTML.Safe.to_iodata()

      value = Phoenix.HTML.Safe.to_iodata(value)

      [?\s, key, ?=, ?", value, ?"]
    end
  end

  @doc "Inserts HTML attributes into an SVG icon"
  def insert_attrs("<svg" <> rest, attrs) do
    Phoenix.HTML.raw(["<svg", attrs, rest])
  end
end
