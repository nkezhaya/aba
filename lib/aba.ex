defmodule ABA do
  @moduledoc """
  ABA is an Elixir library for performing validation and lookups on ABA routing numbers. It stores all routing numbers and bank information in an ETS table. Therefore, you should initialize the application in a supervision tree.

  ## Installation

  Add `aba` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:aba, "~> 0.1.0"}
    ]
  end
  ```

  ## Usage

  To perform routing number validation without an ETS table lookup:

  ```elixir
  iex> ABA.routing_number_valid?("111900659")
  true
  ```

  Otherwise, performing lookups can be done with:

  ```elixir
  iex> ABA.get_bank("111900659")
  {:ok, %ABA.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                         address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                         state: "MN", zip: "55479"}}
  ```
  """

  use Application

  @spec start(any(), any()) :: {:ok, pid()} | {:error, any()}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ABA.Registry, [])
    ]

    opts = [strategy: :one_for_one, name: ABA.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Looks up bank info via the routing number passed.

  ## Examples

      iex> ABA.get_bank("111900659")
      {:ok, %ABA.Bank{routing_number: "111900659", name: "WELLS FARGO BANK",
                             address: "255 2ND AVE SOUTH", city: "MINNEAPOLIS",
                             state: "MN", zip: "55479"}}

      iex> ABA.get_bank("111XXX659")
      {:error, :invalid}

  """

  @spec get_bank(any) :: {:ok, ABA.Bank.t()} | {:error, :not_found | :invalid}
  def get_bank(routing_number) do
    if routing_number_valid?(routing_number) do
      case ABA.Registry.lookup(routing_number) do
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

      iex> ABA.routing_number_valid?("111900659")
      true

      iex> ABA.routing_number_valid?("111900658")
      false

  """
  defdelegate routing_number_valid?(routing_number),
    to: ABA.Validator
end
