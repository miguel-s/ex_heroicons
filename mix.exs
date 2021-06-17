defmodule Heroicons.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_heroicons,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
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

  defp deps do
    [
      {:phoenix_html, "~> 2.14"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:surface, "~> 0.5", optional: true}
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
