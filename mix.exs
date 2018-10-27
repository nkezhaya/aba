defmodule ABA.Mixfile do
  use Mix.Project

  def project do
    [
      app: :aba,
      version: "0.3.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger], mod: {ABA, []}]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :doc}, {:dialyxir, "~> 1.0.0-rc.3", only: :dev, runtime: false}]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Nick Kezhaya <nick@whitepaperclip.com>"],
      links: %{"GitHub" => "https://github.com/whitepaperclip/ABA"}
    ]
  end

  defp description do
    "ABA is an Elixir library for performing validation and lookups on ABA routing numbers."
  end
end
