# ABA

ABA is an Elixir library for performing validation and lookups on ABA routing numbers. It stores all routing numbers and bank information in an ETS table. Therefore, you should initialize the application in a supervision tree.

Full docs here: https://hexdocs.pm/aba/index.html

## Installation

Add `aba` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aba, "~> 0.3"}
  ]
end
```

## Usage

To perform routing number validation without an ETS table lookup:

```elixir
iex> ABA.routing_number_valid?("111900659")
true
```

Otherwise, performing lookups can be done with

```elixir
iex> ABA.get_bank("111900659")
{:ok, %ABA.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                       address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                       state: "MN", zip: "55479"}}
```
