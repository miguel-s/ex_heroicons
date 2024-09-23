defmodule Heroicons.Icon do
  @moduledoc """
  This module defines the data structure and functions for working with icons stored as SVG files.
  """

  alias __MODULE__

  @doc """
  Defines the Heroicons.Icon struct.

  Its fields are:

    * `:type` - the type of the icon

    * `:name` - the name of the icon

    * `:file` - the binary content of the file

  """
  defstruct [:type, :name, :file]

  @type t :: %Icon{type: String.t(), name: String.t(), file: binary}

  @doc "Parses a SVG file and returns structured data"
  @spec parse!(String.t()) :: Icon.t()
  def parse!(filename) do
    [type, name] =
      filename
      |> Path.split()
      |> Enum.take(-3)
      |> case do
        ["16", "solid", name] -> ["micro", name]
        ["20", "solid", name] -> ["mini", name]
        ["24", "solid", name] -> ["solid", name]
        ["24", "outline", name] -> ["outline", name]
      end

    name = Path.rootname(name)

    file =
      filename
      |> File.read!()
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.drop(-2)
      |> Enum.map(&String.trim/1)

    %__MODULE__{type: type, name: name, file: file}
  end
end
