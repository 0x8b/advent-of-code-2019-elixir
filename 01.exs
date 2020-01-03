defmodule Day01 do
  @data File.read!("./data/01.txt")
        |> String.trim()
        |> String.split()
        |> Enum.map(&String.to_integer/1)

  def part_one do
    @data
    |> Enum.map(&fuel/1)
    |> Enum.sum()
  end

  def part_two do
    @data
    |> Enum.map(&fuels/1)
    |> Enum.sum()
  end

  def fuel(mass), do: div(mass, 3) - 2

  def fuels(mass) do
    mass
    |> Stream.unfold(&{&1, fuel(&1)})
    |> Stream.take_while(&(&1 > 0))
    |> Stream.drop(1)
    |> Enum.sum()
  end
end

ExUnit.start()

defmodule AssertionTest do
  import Day01
  use ExUnit.Case, async: true

  test "fuel" do
    assert fuel(12) === 2
    assert fuel(14) === 2
    assert fuel(1969) === 654
    assert fuel(100_756) === 33583
  end

  test "fuels" do
    assert fuels(14) === 2
    assert fuels(1969) === 966
    assert fuels(100_756) === 50346
  end
end

IO.puts(Day01.part_one())
IO.puts(Day01.part_two())
