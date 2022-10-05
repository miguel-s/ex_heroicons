defmodule Phxicons.Surface.IconTest do
  use Phxicons.ConnCase, async: true

  alias Phxicons.Surface.Icon

  test "renders icon" do
    html =
      render_surface do
        ~F"""
        <Icon name="AiFillAccountBook" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~F"""
        <Icon name="AiFillAccountBook" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(class="h-4 w-4")
  end

  test "renders icon with opts" do
    html =
      render_surface do
        ~F"""
        <Icon name="AiFillAccountBook" opts={aria_hidden: true} />
        """
      end

    assert html =~ ~s(aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    html =
      render_surface do
        ~F"""
        <Icon name="AiFillAccountBook" class="hello" opts={class: "world"} />
        """
      end

    assert html =~ ~s(class="hello")
  end

  test "raises if icon name does not exist" do
    msg = ~s(could not read file "icons/hello.svg": no such file or directory)

    assert_raise File.Error, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" />
        """
      end
    end
  end
end
