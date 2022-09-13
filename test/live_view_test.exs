defmodule Heroicons.LiveViewTest do
  use Heroicons.ConnCase, async: true
  import Phoenix.LiveView.Helpers

  alias Heroicons.LiveView

  test "renders icon" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" type="outline" />
      """)

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" type="outline" class="h-4 w-4" />
      """)

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" type="outline" opts={[aria_hidden: true]} />
      """)

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" type="outline" class="hello" opts={[class: "world"]} />
      """)

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if icon name does not exist" do
    assigns = %{}
    msg = ~s(icon "hello" with type "outline" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="hello" type="outline" />
      """)
    end
  end

  test "raises if type is missing" do
    assigns = %{}
    msg = ~s(type prop is required if default type is not configured.)

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="hello" />
      """)
    end
  end

  test "raises if icon type does not exist" do
    assigns = %{}
    msg = ~s(expected type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" type="world" />
      """)
    end
  end
end

defmodule Heroicons.LiveViewConfigTest do
  use Heroicons.ConnCase
  import Phoenix.LiveView.Helpers

  alias Heroicons.LiveView

  test "renders icon with default type" do
    Application.put_env(:ex_heroicons, :type, "outline")

    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" />
      """)

    assert html =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_heroicons, :type, "world")

    assigns = %{}
    msg = ~s(expected default type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="academic-cap" />
      """)
    end
  end
end
