defmodule BigBrother.Mixfile do
  use Mix.Project

  def project do
    [app: :big_brother,
     version: "0.1.0",
     elixir: "~> 1.5",
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {BigBrother, []}]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :doc}]
  end

  defp package do
    [licenses: ["MIT"],
     maintainers: ["Nick Kezhaya <nick@whitepaperclip.com>"],
     links: %{"GitHub" => "https://github.com/whitepaperclip/BigBrother"},
     files: ["data.txt", "lib", "mix.exs", "README*", "LICENSE*"]]
  end

  defp description do
    "BigBrother is an Elixir library for performing validation and lookups on ABA routing numbers."
  end
end
