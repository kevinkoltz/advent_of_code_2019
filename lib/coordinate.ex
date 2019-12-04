defmodule Coordinate do
  @moduledoc """
  Functions for working with coordinates.
  """

  @doc """
  Calculate Manhattan Distance between two coordinates.
  """
  def manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  @doc """
  Returns all the points between to coordinates including the coordinates themselves.
  """
  def points_between({x1, y1}, {x2, y2}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end

  @doc """
  Moves a coordinate by `count` positions in a direction.
  """
  def move({x, y}, :up, count), do: {x, y + count}
  def move({x, y}, :right, count), do: {x + count, y}
  def move({x, y}, :down, count), do: {x, y - count}
  def move({x, y}, :left, count), do: {x - count, y}
end
