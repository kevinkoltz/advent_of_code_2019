defmodule RocketModule do
  @moduledoc """
  Rocket module that carries fuel.
  """

  defstruct mass: nil, fuel: nil, fuels_fuel: nil

  @doc """
  Creates a new module.
  """
  def new(mass) do
    fuel = calculate_required_fuel(mass)
    fuels_fuel = calculate_required_fuel_for_fuel(fuel)

    %__MODULE__{
      mass: mass,
      fuel: fuel,
      fuels_fuel: fuels_fuel
    }
  end

  @doc """
  Calculates fuel for a rocket module.

  Fuel required to launch a given module is based on its mass. Specifically, to find the fuel
  required for a module, take its mass, divide by three, round down, and subtract 2.

  # For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.

    iex> RocketModule.calculate_required_fuel(12)
    Decimal.new(2)

  # For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.

    iex> RocketModule.calculate_required_fuel(14)
    Decimal.new(2)

  # For a mass of 1969, the fuel required is 654.

    iex> RocketModule.calculate_required_fuel(1969)
    Decimal.new(654)

  # For a mass of 100756, the fuel required is 33583.

    iex> RocketModule.calculate_required_fuel(100756)
    Decimal.new(33583)

  """
  def calculate_required_fuel(mass) do
    mass
    |> Decimal.div_int(3)
    |> Decimal.sub(2)
  end

  @doc """
  A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and
  rounded down is 0, which would call for a negative fuel), so the total fuel required is still
  just 2.

  Example:

    iex> RocketModule.calculate_required_fuel_for_fuel(14)
    Decimal.new(2)

  At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3
  - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which
  requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70
  + 21 + 5 = 966.

  Example:

    iex> RocketModule.calculate_required_fuel_for_fuel(100_756)
    Decimal.new(50346)

  The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.

  Example:

    iex> RocketModule.calculate_required_fuel_for_fuel(100_756)
    Decimal.new(50346)

  """
  def calculate_required_fuel_for_fuel(input_mass, total \\ Decimal.new(0))
  def calculate_required_fuel_for_fuel(%Decimal{coef: 0}, total), do: total
  def calculate_required_fuel_for_fuel(%Decimal{sign: -1}, total), do: total

  def calculate_required_fuel_for_fuel(input_mass, total) do
    additional = calculate_required_fuel(input_mass)

    new_total =
      total
      |> Decimal.add(additional)
      |> Decimal.max(total)

    calculate_required_fuel_for_fuel(additional, new_total)
  end
end
