defmodule Heroicons.Surface.IconTest do
  use Heroicons.ConnCase, async: true

  alias Heroicons.Surface.Icon

  test "renders icon" do
    html =
      render_surface do
        ~F"""
        <Icon name="academic-cap" type="outline" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~F"""
        <Icon name="academic-cap" type="outline" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    html =
      render_surface do
        ~F"""
        <Icon name="academic-cap" type="outline" opts={aria_hidden: true} />
        """
      end

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    html =
      render_surface do
        ~F"""
        <Icon name="academic-cap" type="outline" class="hello" opts={class: "world"} />
        """
      end

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if icon name does not exist" do
    msg = ~s(icon "hello" with type "outline" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" type="outline" />
        """
      end
    end
  end

  test "raises if type is missing" do
    msg = ~s(type prop is required if default type is not configured.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" />
        """
      end
    end
  end

  test "raises if icon type does not exist" do
    msg = ~s(expected type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="academic-cap" type="world" />
        """
      end
    end
  end
end

defmodule Heroicons.Surface.IconConfigTest do
  use Heroicons.ConnCase

  alias Heroicons.Surface.Icon

  test "renders icon with default type" do
    Application.put_env(:ex_heroicons, :type, "outline")

    html =
      render_surface do
        ~F"""
        <Icon name="academic-cap" />
        """
      end

    assert html =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_heroicons, :type, "world")

    msg = ~s(expected default type to be one of #{inspect(Heroicons.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="academic-cap" />
        """
      end
    end
  end
end
