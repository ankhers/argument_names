defmodule ArgumentNames.MixProject do
  use Mix.Project

  @version "0.2.1"

  def project do
    [
      app: :argument_names,
      version: @version,
      elixir: "~> 1.7",
      deps: deps(),

      # Hex
      description: "An easy to use and pipe friendly way to have named arugments",
      package: package(),

      # Docs
      name: "Argument Names",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Justin Wood"],
      licenses: ["MIT"],
      links: %{
        "sourcehut" => "https://git.sr.ht/~ankhers/argument_names",
        "GitHub" => "https://github.com/ankhers/argument_names"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}",
      source_url: "https://git.sr.ht/~ankhers/argument_names",
      source_url: "https://github.com/ankhers/mongodb"
    ]
  end
end
