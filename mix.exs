defmodule Phxicons.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :elixircl_phxicons,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/elixircl/phxicons"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix_html, "~> 3.2"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:floki, ">= 0.32.0", only: :test},
      {:phoenix_live_view, "~> 0.17", optional: true},
      {:surface, "~> 0.7", optional: true}
    ]
  end

  defp docs do
    [
      main: "Phxicons",
      source_ref: "v#{@version}",
      source_url: "https://github.com/elixircl/phxicons",
      groups_for_modules: [
        Liveview: ~r/Phxicons.LiveView/,
        Surface: ~r/Phxicons.Surface/
      ],
      nest_modules_by_prefix: [
        Phxicons.LiveView,
        Phxicons.Surface
      ],
      extras: ["README.md"]
    ]
  end

  defp description() do
    """
    This package adds a convenient way of using Phxicons with your Phoenix, Phoenix LiveView and Surface applications.

    Phxicons is "A set of popular high-quality SVG icons for you to use in your web projects."

    Icons are taken from the other projects, so please check each project licences accordingly.
    """
  end

  defp package do
    %{
      files: ~w(lib priv icons .formatter.exs mix.exs README* LICENSE* CHANGELOG* VERSIONS*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/elixircl/phxicons"}
    }
  end
end
