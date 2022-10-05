defmodule Phxicons.Surface.Icon.Example do

  use Surface.Catalogue.Example,
  catalogue: Phxicons.Surface.Catalogue,
  subject: Phxicons.Surface.Icon,
  direction: "vertical",
  height: "500px",
  title: "Surface PhxIcon"

  alias Phxicons.Surface.Icon

  def render(assigns) do
    ~F"""
      <Icon name="TbZoomQuestion"/>
      <p class="white-text">TbZoomQuestion</p>
    """
  end

end
