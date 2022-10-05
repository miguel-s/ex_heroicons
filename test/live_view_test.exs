defmodule Phxicons.LiveViewTest do
  use Phxicons.ConnCase, async: true
  import Phoenix.LiveView.Helpers

  alias Phxicons.LiveView

  test "renders icon" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="AiFillAccountBook" />
      """)

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="AiFillAccountBook" class="h-4 w-4" />
      """)

    assert html =~ ~s(class="h-4 w-4")
  end

  test "renders icon with opts" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="AiFillAccountBook" opts={[aria_hidden: true]} />
      """)

    assert html =~ ~s(aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="AiFillAccountBook" class="hello" opts={[class: "world"]} />
      """)

    assert html =~ ~s(class="hello")
  end

  test "raises if icon name does not exist" do
    assigns = %{}
    msg = ~s(could not read file "icons/hello.svg": no such file or directory)

    assert_raise File.Error, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="hello" />
      """)
    end
  end

end
