defmodule ReactPhoenix.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @source_url "https://github.com/geolessel/react-phoenix"

  def project do
    [
      app: :react_phoenix,
      version: @version,
      elixir: "~> 1.5",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger, :phoenix_html, :jason]]
  end

  def description do
    """
    A helper library for easily rendering React components in
    Phoenix projects. Built to work out of the box with brunch.
    """
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, ">= 0.5.0", only: :dev},
      {:phoenix_html, "~> 2.11"},
      {:jason, "~> 1.1"}
    ]
  end

  defp package do
    [
      name: :react_phoenix,
      files: ["lib", "priv", "mix.exs", "package.json", "README*", "LICENSE*"],
      maintainers: ["Geoffrey Lessel"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      name: "ReactPhoenix",
      source_url: @source_url,
      homepage_url: "http://reactphoenix.com",
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
