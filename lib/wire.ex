defmodule Wire do
  @moduledoc """
  --- Day 3: Crossed Wires ---

  The gravity assist was successful, and you're well on your way to the Venus refuelling station.
  During the rush back on Earth, the fuel management system wasn't completely installed, so that's
  next on the priority list.

  Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a
  central port and extend outward on a grid. You trace the path each wire takes as it leaves the
  central port, one wire per line of text (your puzzle input).
  """

  @central_port {0, 0}

  @doc """
  Find the closest wire intersection from the central port.

  The wires twist and turn, but the two wires occasionally cross paths. To fix the circuit, you
  need to find the intersection point closest to the central port. Because the wires are on a
  grid, use the Manhattan distance for this measurement. While the wires do technically cross
  right at the central port where they both start, this point does not count, nor does a wire
  count as crossing with itself.

  For example, if the first wire's path is R8,U5,L5,D3, then starting from the central port (o),
  it goes right 8, up 5, left 5, and finally down 3:

  ...........
  ...........
  ...........
  ....+----+.
  ....|....|.
  ....|....|.
  ....|....|.
  .........|.
  .o-------+.
  ...........

  Then, if the second wire's path is U7,R6,D4,L4, it goes up 7, right 6, down 4, and left 4:

  ...........
  .+-----+...
  .|.....|...
  .|..+--X-+.
  .|..|..|.|.
  .|.-X--+.|.
  .|..|....|.
  .|.......|.
  .o-------+.
  ...........

  These wires cross at two locations (marked X), but the lower-left one is closer to the central
  port: its distance is 3 + 3 = 6.

      iex> Wire.find_intersection_distance("R8,U5,L5,D3", "U7,R6,D4,L4")
      6

  Example with negative intersection {155, -12}:

      iex> wire_1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
      ...> wire_2 = "U62,R66,U55,R34,D71,R55,D58,R83"
      ...> Wire.find_intersection_distance(wire_1, wire_2)
      159

  Another example:

      iex> wire_1 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
      ...> wire_2 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      ...> Wire.find_intersection_distance(wire_1, wire_2)
      135

  What is the Manhattan distance from the central port to the closest intersection?
  """
  def find_intersection_distance(w1, w2) do
    with wire_1_points <- map_wire(w1),
         wire_2_points <- map_wire(w2),
         intersections <- MapSet.intersection(wire_1_points, wire_2_points) do
      intersections
      |> Enum.map(&Coordinate.manhattan_distance(&1, @central_port))
      |> Enum.sort()
      |> Enum.at(1)
    end
  end

  defp map_wire(wire, points \\ MapSet.new(), last_pos \\ @central_port)

  defp map_wire(wire, points, last_pos) when is_binary(wire) do
    wire
    |> decode()
    |> map_wire(points, last_pos)
  end

  defp map_wire([], points, _), do: points

  defp map_wire([segment | t], points, last_pos) do
    new_pos = last_pos |> move(segment)

    new_points =
      last_pos
      |> points_between(new_pos)
      |> Enum.reduce(points, fn point, acc -> MapSet.put(acc, point) end)

    map_wire(t, new_points, new_pos)
  end

  defp points_between({x1, y1}, {x2, y2}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end

  defp move({x, y}, {:up, count}), do: {x, y + count}
  defp move({x, y}, {:right, count}), do: {x + count, y}
  defp move({x, y}, {:down, count}), do: {x, y - count}
  defp move({x, y}, {:left, count}), do: {x - count, y}

  @doc """
  Decodes a wire from a string.
  """
  def decode(wire) when is_binary(wire) do
    wire
    |> String.split(",")
    |> Enum.map(fn
      "U" <> count -> {:up, String.to_integer(count)}
      "R" <> count -> {:right, String.to_integer(count)}
      "D" <> count -> {:down, String.to_integer(count)}
      "L" <> count -> {:left, String.to_integer(count)}
    end)
  end
end
