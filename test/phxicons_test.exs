defmodule PhxiconsTest do
  use ExUnit.Case, async: true
  doctest Phxicons

  test "renders icon" do
    assert Phxicons.icon("AiFillAccountBook")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "renders icon with attribute" do
    assert Phxicons.icon("AiFillAccountBook", class: "h-4 w-4")
           |> Phoenix.HTML.safe_to_string() =~ ~s(class="h-4 w-4")
  end

  test "converts opts to attributes" do
    assert Phxicons.icon("AiFillAccountBook", aria_hidden: true)
           |> Phoenix.HTML.safe_to_string() =~ ~s(aria-hidden="true")
  end

  test "raises if icon name does not exist" do
    msg = ~s(could not read file "icons/hello.svg": no such file or directory)

    assert_raise File.Error, msg, fn ->
      Phxicons.icon("hello")
    end
  end
end
