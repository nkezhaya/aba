defmodule BigBrother.Validator do
  @moduledoc false

  @spec routing_number_valid?(any) :: boolean
  def routing_number_valid?(routing_number) do
    [a, b, c, d, e, f, g, h, i] =
      routing_number
      |> String.split("")
      |> List.delete_at(9)
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {digit, _} -> digit end)

    total =
      (a * 3) + (b * 7) + (c * 1) +
      (d * 3) + (e * 7) + (f * 1) +
      (g * 3) + (h * 7) + (i * 1)

    Integer.mod(total, 10) == 0
  rescue _ ->
    false
  end
end
