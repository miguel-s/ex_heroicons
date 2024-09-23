defmodule HeroiconsTest do
  use ExUnit.Case, async: true
  import Phoenix.Component
  import Phoenix.LiveViewTest
  doctest Heroicons

  test "renders icon" do
    assigns = %{}
    html = rendered_to_string(~H[<Heroicons.icon name="academic-cap" />])

    assert html =~
             ~s(<!-- heroicons-outline-academic-cap -->\n<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" data-slot="icon" class="">\n  \n  <path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.438 60.438 0 0 0-.491 6.347A48.62 48.62 0 0 1 12 20.904a48.62 48.62 0 0 1 8.232-4.41 60.46 60.46 0 0 0-.491-6.347m-15.482 0a50.636 50.636 0 0 0-2.658-.813A59.906 59.906 0 0 1 12 3.493a59.903 59.903 0 0 1 10.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.717 50.717 0 0 1 12 13.489a50.702 50.702 0 0 1 7.74-3.342M6.75 15a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm0 0v-3.675A55.378 55.378 0 0 1 12 8.443m-7.007 11.55A5.981 5.981 0 0 0 6.75 15.75v-1.5"/>\n\n</svg>)
  end

  test "renders icon with default type" do
    assigns = %{}
    html = rendered_to_string(~H[<Heroicons.icon name="academic-cap" />])
    assert html =~ ~s(heroicons-outline-academic-cap)
  end

  test "renders icon with explicit type" do
    assigns = %{}
    html = rendered_to_string(~H[<Heroicons.icon name="academic-cap" type="solid" />])
    assert html =~ ~s(heroicons-solid-academic-cap)
  end

  test "renders icon with class" do
    assigns = %{}
    html = rendered_to_string(~H[<Heroicons.icon name="academic-cap" class="h-4 w-4" />])
    assert html =~ ~s(class="h-4 w-4")
  end

  test "renders icon with global attributes" do
    assigns = %{}
    html = rendered_to_string(~H[<Heroicons.icon name="academic-cap" aria-hidden="true" />])
    assert html =~ ~s(aria-hidden="true")
  end

  test "raises when icon name is not found" do
    assigns = %{}

    assert_raise ArgumentError,
                 "expected icon name to be one of #{inspect(Heroicons.names())}, got: nil",
                 fn ->
                   rendered_to_string(~H[<Heroicons.icon />])
                 end
  end

  test "raises when icon name is invalid" do
    assigns = %{}

    assert_raise ArgumentError,
                 "expected icon name to be one of #{inspect(Heroicons.names())}, got: \"invalid\"",
                 fn ->
                   rendered_to_string(~H[<Heroicons.icon name="invalid" />])
                 end
  end

  test "raises when icon type is not found" do
    assigns = %{}

    assert_raise ArgumentError,
                 "expected icon type to be one of #{inspect(Heroicons.types())}, got: nil",
                 fn ->
                   rendered_to_string(~H[<Heroicons.icon name="academic-cap" type={nil} />])
                 end
  end

  test "raises when icon type is invalid" do
    assigns = %{}

    assert_raise ArgumentError,
                 "expected icon type to be one of #{inspect(Heroicons.types())}, got: \"invalid\"",
                 fn ->
                   rendered_to_string(~H[<Heroicons.icon name="academic-cap" type="invalid" />])
                 end
  end
end
