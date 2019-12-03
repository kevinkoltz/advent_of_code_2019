defmodule Aoc19Test do
  use ExUnit.Case
  doctest Aoc19
  doctest RocketModule
  doctest Intcode

  test "day 1" do
    masses = read_puzzle_input("day_01_input.txt", delim: "\n", formatter: &Decimal.new/1)

    rocket = Rocket.new(masses)

    # part 1
    assert Rocket.initial_fuel_required(rocket) == Decimal.new(3_303_995)

    # part 2
    assert Rocket.total_fuel_required(rocket) == Decimal.new(4_953_118)
  end

  test "day 2" do
    program = read_puzzle_input("day_02_input.txt", delim: ",", formatter: &String.to_integer/1)

    # part 1
    assert [position_0 | _] = Intcode.restore(program, 12, 2)
    assert position_0 == 5_434_663
  end

  @doc """
  Reads puzzle input from a text file.
  """
  def read_puzzle_input(filename, opts) do
    delim = Keyword.fetch!(opts, :delim)
    formatter = Keyword.fetch!(opts, :formatter)

    filename
    |> File.read!()
    |> String.trim()
    |> String.split(delim)
    |> Enum.map(&formatter.(&1))
  end
end
