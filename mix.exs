defmodule Heroicons.MixProject do
  use Mix.Project

  @version "0.6.1"

  def project do
    [
      app: :ex_heroicons,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/miguel-s/ex_heroicons"
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
      main: "Heroicons",
      source_ref: "v#{@version}",
      source_url: "https://github.com/miguel-s/ex_heroicons",
      groups_for_modules: [
        Liveview: ~r/Heroicons.LiveView/,
        Surface: ~r/Heroicons.Surface/
      ],
      nest_modules_by_prefix: [
        Heroicons.LiveView,
        Heroicons.Surface
      ],
      extras: ["README.md"]
    ]
  end

  defp description() do
    """
    This package adds a convenient way of using Heroicons with your Phoenix, Phoenix LiveView and Surface applications.

    Heroicons is "A set of 450+ free MIT-licensed high-quality SVG icons for you to use in your web projects."
    Created by the amazing folks at Tailwind Labs.
    """
  end

  defp package do
    %{
      files: ~w(lib node_modules .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/miguel-s/ex_heroicons"}
    }
  end
end
