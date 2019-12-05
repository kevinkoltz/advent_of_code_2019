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
    digits = Integer.digits(password)

    has_adjacent_digits?(digits) &&
      not has_decreasing_digits?(digits)
  end

  defp has_adjacent_digits?([_]), do: false
  defp has_adjacent_digits?([a, a | _]), do: true
  defp has_adjacent_digits?([_, b | t]), do: has_adjacent_digits?([b | t])

  defp has_decreasing_digits?(digits), do: digits != Enum.sort(digits)
end
