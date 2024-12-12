{listOne, listTwo} = File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn (data) ->
        String.split(data)
            |> Enum.map(&String.to_integer/1)
            |> List.to_tuple
    end)
    |> Enum.unzip

Enum.zip(Enum.sort(listOne), Enum.sort(listTwo))
    |> Enum.map(fn ({one, two}) -> abs(two - one) end)
    |> Enum.sum
    |> IO.puts

freqMap = Enum.frequencies(listTwo)

Enum.map(listOne, fn x ->
    case Map.get(freqMap, x) do
        nil -> 0
        y -> (y * x)
    end
end)
    |> Enum.sum
    |> IO.puts
