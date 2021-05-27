defmodule Heroicons.Components.IconTest do
  use ExUnit.Case, async: true
  use Surface.LiveViewTest

  alias Heroicons.Components.Icon

  @endpoint Endpoint

  test "renders icon" do
    html =
      render_surface do
        ~H"""
        <Icon type="outline" name="academic-cap" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~H"""
        <Icon type="outline" name="academic-cap" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    html =
      render_surface do
        ~H"""
        <Icon type="outline" name="academic-cap" opts={{ aria_hidden: true }} />
        """
      end

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    html =
      render_surface do
        ~H"""
        <Icon type="outline" name="academic-cap" class="hello" opts={{ class: "world" }} />
        """
      end

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if type or icon don't exist" do
    msg = ~s(icon of type "hello" with name "academic-cap" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~H"""
        <Icon type="hello" name="academic-cap" />
        """
      end
    end

    msg = ~s(icon of type "outline" with name "world" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~H"""
        <Icon type="outline" name="world" />
        """
      end
    end
  end
end
