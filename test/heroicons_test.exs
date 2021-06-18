defmodule HeroiconsTest do
  use ExUnit.Case, async: true
  doctest Heroicons

  test "renders icon" do
    assert Heroicons.icon("academic-cap", type: "outline")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "renders icon with attribute" do
    assert Heroicons.icon("academic-cap", type: "outline", class: "h-4 w-4")
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg class="h-4 w-4")
  end

  test "converts opts to attributes" do
    assert Heroicons.icon("academic-cap", type: "outline", aria_hidden: true)
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg aria-hidden="true")
  end

  test "raises if icon name does not exist" do
    msg = ~s(icon "hello" with type "outline" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("hello", type: "outline")
    end
  end

  test "raises if type is missing" do
    msg = ~s(expected type in options, got: [])

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("academic-cap")
    end
  end

  test "raises if icon type does not exist" do
    msg = ~s(expected type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("academic-cap", type: "world")
    end
  end
end

defmodule HeroiconsConfigTest do
  use ExUnit.Case

  test "renders icon with default type" do
    Application.put_env(:ex_heroicons, :type, "outline")

    assert Heroicons.icon("academic-cap")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_heroicons, :type, "world")

    msg = ~s(expected default type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      Heroicons.icon("academic-cap")
    end
  end
end
