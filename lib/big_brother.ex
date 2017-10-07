defmodule BigBrother do
  @moduledoc """
  BigBrother is an Elixir library for performing validation and lookups on ABA routing numbers. It stores all routing numbers and bank information in an ETS table. Therefore, you should initialize the application in a supervision tree.

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

  Otherwise, performing lookups can be done with:

  ```elixir
  iex> BigBrother.get_bank("111900659")
  {:ok, %BigBrother.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                         address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                         state: "MN", zip: "55479"}}
  ```
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(BigBrother.Registry, [])
    ]

    opts = [strategy: :one_for_one, name: BigBrother.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Looks up bank info via the routing number passed.

  ## Examples

      iex> BigBrother.get_bank("111900659")
      {:ok, %BigBrother.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                             address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                             state: "MN", zip: "55479"}}

      iex> BigBrother.get_bank("111XXX659")
      {:error, :invalid}

  """


  @spec get_bank(any) :: {:ok, Bank} | {:error, :not_found | :invalid}
  def get_bank(routing_number) do
    if routing_number_valid?(routing_number) do
      case BigBrother.Registry.lookup(routing_number) do
        nil -> {:error, :not_found}
        bank -> {:ok, bank}
      end
    else
      {:error, :invalid}
    end
  end

  @doc """
  Validates the routing number. Can be passed any Elixir term.

  ## Examples

      iex> BigBrother.routing_number_valid?("111900659")
      true

      iex> BigBrother.routing_number_valid?("111900658")
      false
    
  """
  defdelegate routing_number_valid?(routing_number),
              to: BigBrother.Validator
end
