defmodule Password do
  @moduledoc """
  --- Day 4: Secure Container ---
  You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had
  written the password on a sticky note, but someone threw it out.

  However, they do remember a few key facts about the password:

  - It is a six-digit number.
  - The value is within the range given in your puzzle input.
  - Two adjacent digits are the same (like 22 in 122345).
  - Going from left to right, the digits never decrease; they only ever increase or stay the same
    (like 111123 or 135679).

  Other than the range rule, the following are true:

  - 111111 meets these criteria (double 11, never decreases).
  - 223450 does not meet these criteria (decreasing pair of digits 50).
  - 123789 does not meet these criteria (no double).

  """

  @doc """
  How many different passwords within the range given in your puzzle input meet these criteria?
  """
  def valid_passwords_in_range(range) do
    for password <- range, valid?(password), do: password
  end

  def valid?(password) when is_integer(password) do
    rules = [
      &has_two_adjacent_digits?/1,
      &(not has_decreasing_digits?(&1))
    ]

    digits = Integer.digits(password)

    Enum.all?(rules, & &1.(digits))
  end

  @doc """
  --- Part Two ---
  An Elf just remembered one more important detail: the two adjacent matching digits are not part of
  a larger group of matching digits.

  Given this additional criterion, but still ignoring the range rule, the following are now true:

  112233 meets these criteria because the digits never decrease and all repeated digits are exactly
  two digits long.

      iex> 112233 |> Integer.digits() |> Password.has_two_adjacent_digits?()
      true

  123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).

      iex> 123444 |> Integer.digits() |> Password.has_two_adjacent_digits?()
      false

  111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double
  22).

      iex> 111122 |> Integer.digits() |> Password.has_two_adjacent_digits?()
      true

  How many different passwords within the range given in your puzzle input meet all of the criteria?
  """
  def has_two_adjacent_digits?([a, a, b, _, _, _]) when a != b, do: true
  def has_two_adjacent_digits?([a, b, b, c, _, _]) when a != b and b != c, do: true
  def has_two_adjacent_digits?([_, a, b, b, c, _]) when a != b and b != c, do: true
  def has_two_adjacent_digits?([_, _, a, b, b, c]) when a != b and b != c, do: true
  def has_two_adjacent_digits?([_, _, _, a, b, b]) when a != b, do: true
  def has_two_adjacent_digits?(_), do: false

  defp has_decreasing_digits?(digits), do: digits != Enum.sort(digits)
end
