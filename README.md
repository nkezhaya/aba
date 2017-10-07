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

First, start a link to the application in your supervision tree:

```elixir
defmodule MyApp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # ... your supervised applications here ...

      supervisor(BigBrother, [])
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

Note that validations do *not* require ETS table lookups, so validation can be performed without starting the application.

```elixir
iex> BigBrother.valid_routing_number?("111900659")
true
```

Otherwise, performing lookups can be done with

```elixir
iex> BigBrother.get_bank("111900659")
{:ok, %BigBrother.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                       address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                       state: "MN", zip: "55479"}}
```
