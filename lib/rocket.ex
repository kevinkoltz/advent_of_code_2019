defmodule Rocket do
  @moduledoc """
  Spacecraft with modules that carry fuel.
  """

  defstruct rocket_modules: []

  @doc """
  Creates a new rocket.
  """
  def new(masses) do
    rocket_modules =
      masses
      |> Enum.map(&RocketModule.new/1)

    %__MODULE__{rocket_modules: rocket_modules}
  end

  @doc """
  --- Day 1: The Tyranny of the Rocket Equation ---

  Santa has become stranded at the edge of the Solar System while delivering presents to other
  planets! To accurately calculate his position in space, safely align his warp drive, and return to
  Earth in time to save Christmas, he needs you to bring him measurements from fifty stars.

  Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent
  calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star.
  Good luck!

  The Elves quickly load you into a spacecraft and prepare to launch.

  At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't
  determined the amount of fuel required yet.

  The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually
  calculate the fuel needed for the mass of each module (your puzzle input), then add together all
  the fuel values.

  What is the sum of the fuel requirements for all of the modules on your spacecraft?
  """
  def initial_fuel_required(%{rocket_modules: rocket_modules} = _rocket) do
    rocket_modules
    |> Enum.map(& &1.fuel)
    |> Enum.reduce(Decimal.new(0), &Decimal.add(&1, &2))
  end

  @doc """
  --- Day 1 - Part Two ---

  During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops
  the launch sequence. Apparently, you forgot to include additional fuel for the fuel you just
  added.

  Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and
  subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any
  mass that would require negative fuel should instead be treated as if it requires zero fuel; the
  remaining mass, if any, is instead handled by wishing really hard, which has no mass and is
  outside the scope of this calculation.

  What is the sum of the fuel requirements for all of the modules on your spacecraft when also
  taking into account the mass of the added fuel? (Calculate the fuel requirements for each module
  separately, then add them all up at the end.)
  """
  def total_fuel_required(%{rocket_modules: rocket_modules} = _rocket) do
    rocket_modules
    |> Enum.reduce(Decimal.new(0), fn rocket_module, total ->
      total
      |> Decimal.add(rocket_module.fuel)
      |> Decimal.add(rocket_module.fuels_fuel)
    end)
  end
end
