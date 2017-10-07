defmodule BigBrother.Registry do
  @moduledoc false
  use GenServer
  alias BigBrother.Bank

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  ## Server callbacks

  def init(_) do
    table = :ets.new(__MODULE__, [])

    File.stream!("data.txt")
    |> Stream.each(fn line ->
      routing = String.slice(line, 0,    9)
      bank    = String.slice(line, 35,  36) |> String.trim
      address = String.slice(line, 71,  36) |> String.trim
      city    = String.slice(line, 107, 20) |> String.trim
      state   = String.slice(line, 127,  2)
      zip     = String.slice(line, 129,  5)

      :ets.insert(table, {routing, [bank, address, city, state, zip]})
    end)
    |> Stream.run

    {:ok, table}
  end

  def handle_call({:lookup, routing_number}, _from, table) do
    result = case :ets.lookup(table, routing_number) do
      [{routing_number, bank_data}] when is_list(bank_data) ->
        Bank.bank(routing_number, bank_data)
      _ -> nil
    end

    {:reply, result, table}
  end

  ## Client API

  @spec lookup(String.t) :: {:ok, Bank.t} | {:error, :not_found}
  def lookup(routing_number) when is_bitstring(routing_number) do
    GenServer.call(__MODULE__, {:lookup, routing_number})
  end
end
