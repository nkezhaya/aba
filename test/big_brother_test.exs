defmodule BigBrotherTest do
  use ExUnit.Case
  doctest BigBrother

  test "validator passes" do
    assert BigBrother.routing_number_valid?("111900659")
    refute BigBrother.routing_number_valid?("111900658")
    refute BigBrother.routing_number_valid?("11190065")
    refute BigBrother.routing_number_valid?("11190065X")
    refute BigBrother.routing_number_valid?("X11900659")
    refute BigBrother.routing_number_valid?("X1190065X")
    refute BigBrother.routing_number_valid?("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
    assert BigBrother.routing_number_valid?("789456124")
  end
end
