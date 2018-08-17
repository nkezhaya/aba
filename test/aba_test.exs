defmodule ABATest do
  use ExUnit.Case
  doctest ABA

  test "validator passes" do
    assert ABA.routing_number_valid?("111900659")
    refute ABA.routing_number_valid?("111900658")
    refute ABA.routing_number_valid?("11190065")
    refute ABA.routing_number_valid?("11190065X")
    refute ABA.routing_number_valid?("X11900659")
    refute ABA.routing_number_valid?("X1190065X")
    refute ABA.routing_number_valid?("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
    assert ABA.routing_number_valid?("789456124")
  end
end
