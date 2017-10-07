# BigBrother

BigBrother is an Elixir library for performing validation and lookups on ABA routing numbers. It stores all routing numbers and bank information in an ETS table. Therefore, you should initialize the application in a supervision tree.

Full docs here: https://hexdocs.pm/big_brother/BigBrother.html

## Installation

Add `big_brother` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:big_brother, "~> 0.1.0"}
  ]
end
```

## Usage

To perform routing number validation without an ETS table lookup:

```elixir
iex> BigBrother.routing_number_valid?("111900659")
true
```

Otherwise, performing lookups can be done with

```elixir
iex> BigBrother.get_bank("111900659")
{:ok, %BigBrother.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                       address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                       state: "MN", zip: "55479"}}
```
