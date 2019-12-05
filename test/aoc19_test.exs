defmodule Aoc19Test do
  use ExUnit.Case
  doctest Aoc19
  doctest RocketModule
  doctest Intcode
  doctest Wire

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

    # part 2
    assert Intcode.complete_gravity_assist(program) == 4559
  end

  test "day 3" do
    [wire_1, wire_2] =
      read_puzzle_input("day_03_input.txt", delim: "\n", formatter: &String.trim/1)

    # part 1
    assert Wire.find_intersection_distance(wire_1, wire_2) == 403
  end

  test "day 4" do
    input_range = 153_517..630_395

    passwords = Password.valid_passwords_in_range(input_range)

    # part 1
    assert length(passwords) == 1729
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
