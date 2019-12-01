defmodule Aoc19Test do
  use ExUnit.Case
  doctest Aoc19
  doctest RocketModule

  test "day 1" do
    masses =
      "day_01_input.txt"
      |> File.read!()
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&Decimal.new(&1))

    rocket = Rocket.new(masses)

    # part 1
    assert Rocket.initial_fuel_required(rocket) == Decimal.new(3_303_995)

    # part 2
    assert Rocket.total_fuel_required(rocket) == Decimal.new(4_953_118)
  end
end
