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
    input("sample.txt")
      |> Enum.map(fn line ->
        line
        |> Enum.reduce_while({0, 0, :ok}, fn (el, acc) ->
          case acc do
            {0, 0, :ok} ->
              {:cont, {el, 0, :ok}}
            {x, 0, :ok} ->
              if x - el < 0 && abs(x - el) <= 3 do
                {:cont, {el, 0, :inc}}
              else
                if x == el do
                  {:halt, :bad}
                else
                  if abs(x - el) > 3 do
                    {:cont, {el, 1, :dec}}
                  else
                    {:cont, {el, 0, :dec}}
                  end
                end
              end
            {x, y, :inc} ->
              if x - el < 0 && abs(x - el) <= 3 do
                {:cont, {el, 0, :inc}}
              else
                if y == 1 do
                  {:halt, :bad}
                else
                  {:cont, {el, 1, :inc}}
                end
              end
            {x, y, :dec} ->
              if x - el > 0 && abs(x - el) <= 3 do
                {:cont, {el, 0, :dec}}
              else
                if y == 1 do
                  {:halt, :bad}
                else
                  {:cont, {el, 1, :dec}}
                end
              end
          end
        end)
      end)
      |> Enum.filter(fn (x) -> x != :bad end)
      |> Enum.count
      |> IO.puts
  end
end

DayTwo.partTwo()
