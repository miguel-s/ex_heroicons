defmodule Phxicons.Icon do
  @moduledoc """
  This module defines the data structure and functions for working with icons stored as SVG files.
  """

  alias __MODULE__

  @doc """
  Defines the Phxicons.Icon struct.

  Its fields are:

    * `:name` - the name of the icon

    * `:file` - the binary of the icon

  """
  defstruct [:name, :file]

  @type t :: %Icon{name: String.t(), file: binary}

  @doc "Parses a SVG file and returns structured data"
  @spec parse!(String.t()) :: Icon.t()
  def parse!(filename) do
    name =
      filename
      |> Path.split()
      |> List.last()

    name = Path.rootname(name)
    file = File.read!(filename)

    struct!(__MODULE__, name: name, file: file)
  end

  def empty() do
    struct!(__MODULE__, name: "", file: "")
  end

  @doc "Converts opts to HTML attributes"
  @spec opts_to_attrs(keyword) :: list
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
  @spec insert_attrs(binary, keyword) :: Phoenix.HTML.safe()
  def insert_attrs("<svg" <> rest, attrs) do
    Phoenix.HTML.raw(["<svg", attrs, rest])
  end
end
