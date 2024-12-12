defmodule DayTwo do
  def input(x) do
    File.read!(x)
      |> String.split("\n", trim: true)
      |> Enum.map(fn (line) ->
        String.split(line, " ", trim: true)
          |> Enum.map(&String.to_integer/1)
      end)
  end

  # Part 1
  def partOne() do
    input("input.txt")
      |> Enum.map(fn line ->
        line
        |> Enum.reduce_while({0, :ok}, fn (el, acc) ->
          case acc do
            {0, :ok} ->
              {:cont, {el, :ok}}
            {x, :ok} ->
              if x - el < 0 && abs(x - el) <= 3 do
                {:cont, {el, :inc}}
              else
                if x == el || abs(x - el) > 3 do
                  {:halt, :bad}
                else
                  {:cont, {el, :dec}}
                end
              end
            {x, :inc} ->
              if x - el < 0 && abs(x - el) <= 3 do
                {:cont, {el, :inc}}
              else
                {:halt, :bad}
              end
            {x, :dec} ->
              if x - el > 0 && abs(x - el) <= 3 do
                {:cont, {el, :dec}}
              else
                {:halt, :bad}
              end
          end
        end)
      end)
      |> Enum.filter(fn (x) -> x != :bad end)
      |> Enum.count
      |> IO.puts
  end

  def partTwo() do
  end
end
