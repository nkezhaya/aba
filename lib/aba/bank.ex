defmodule ABA.Bank do
  @moduledoc """
  Defines a structure representing a bank and its ABA information.

  The struct contains:

    * Routing number
    * Name
    * Address
    * City
    * State
    * Zip
  """

  @enforce_keys ~w(routing_number name address city state zip)a
  defstruct ~w(routing_number name address city state zip)a

  @type t :: %__MODULE__{
          routing_number: String.t(),
          name: String.t(),
          address: String.t(),
          city: String.t(),
          state: String.t(),
          zip: String.t()
        }

  @spec bank(String.t(), [String.t()]) :: t | none
  def bank(routing_number, bank_data)
      when is_bitstring(routing_number) and is_list(bank_data) and length(bank_data) == 5 do
    [name, address, city, state, zip] = Enum.filter(bank_data, &is_bitstring(&1))

    %__MODULE__{
      routing_number: routing_number,
      name: name,
      address: address,
      city: city,
      state: state,
      zip: zip
    }
  end

  def bank(routing_number, bank_data),
    do: raise("Invalid bank data: #{routing_number} #{bank_data}")
end
