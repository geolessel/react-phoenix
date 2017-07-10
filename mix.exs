defmodule ReactPhoenix.Mixfile do
  use Mix.Project

  @version "0.4.3"
  @source_url "https://github.com/geolessel/react-phoenix"

  def project do
    [app: :react_phoenix,
     version: @version,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     description: description(),
     deps: deps(),
     docs: docs()]
  end

  def application do
    [applications: [:logger, :phoenix_html, :poison, :std_json_io_2],
     mod: {ReactPhoenix.Application, []}]
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
      {:phoenix_html, "~> 2.9"},
      {:poison, "~> 2.2 or ~> 3.0"},
      {:std_json_io_2, "~> 0.2"}
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
