defmodule Aoc19.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_19,
      version: "0.1.0",
      elixir: "~> 1.10-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:decimal, "~> 1.0"},
      {:mix_test_watch, "~> 1.0.0"},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false}
    ]
  end
end
