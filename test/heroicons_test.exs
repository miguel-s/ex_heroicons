defmodule HeroiconsTest do
  use ExUnit.Case
  doctest Heroicons

  test "renders icon" do
    assert Heroicons.icon("outline", "academic-cap")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "renders icon with class" do
    assert Heroicons.icon("outline", "academic-cap", class: "h-4 w-4")
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg class="h-4 w-4")
  end

  test "raises if type or icon don't exist" do
    msg = ~s(icon of type "hello" with name "academic-cap" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("hello", "academic-cap")
    end

    msg = ~s(icon of type "outline" with name "world" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("outline", "world")
    end
  end
end
