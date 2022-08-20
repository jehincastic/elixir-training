# Enum.__info__(:functions) |> Enum.each(fn({function, arity}) ->
#   IO.puts "#{function}/#{arity}"
# end)
# The above line lists all availabe enums in elixir

isLengthThree = Enum.all?(["foo", "bar", "hello"], fn(s) -> String.length(s) === 3 end)
IO.puts isLengthThree # => false

isAnyLengthThree = Enum.any?(["foo", "bar", "hello"], fn(s) -> String.length(s) === 3 end)
IO.puts isAnyLengthThree # => false

chunkedList = Enum.chunk_every([1, 2, 3, 4, 5], 2)
IO.inspect chunkedList # => [[1, 2], [3, 4], [5]]

chunkedBy = Enum.chunk_by(["one", "two", "three", "four", "five", "six"], fn(x) -> String.length(x) end)
IO.inspect chunkedBy # chunkedBy conly combines consecutive elements with the same value

newList = Enum.map_every([1, 2, 3, 4, 5, 6, 7, 8], 3, fn x -> x + 1000 end)
# this applies the function to every third element in the list
IO.inspect newList # => [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008]

Enum.each(["one", "two", "three"], fn(s) -> IO.puts(s) end)

newList = Enum.map(["one", "two", "three"], fn(s) -> s <> "!" end)
IO.inspect newList # => ["one!", "two!", "three!"]

IO.puts Enum.min([1, 2, 3, 4, 5, 6, 7, 8]) # => 1
IO.puts Enum.min([], fn -> :none end) # => :none

IO.puts Enum.max([1, 2, 3, 4, 5, 6, 7, 8]) # => 8
IO.puts Enum.max([], fn -> :none end) # => :none

evenNos = Enum.filter([1, 2, 3, 4], fn(x) -> rem(x, 2) == 0 end)
IO.inspect evenNos # => [2, 4]

sum = Enum.reduce([1, 2, 3, 4], fn(x, acc) -> x + acc end)
IO.puts sum # => 10

sum = Enum.reduce([1, 2, 3, 4], 5, fn(x, acc) -> x + acc end)
IO.puts sum # => 15

sortedlist = Enum.sort([5, 6, 1, 3, -1, 4])
IO.inspect sortedlist # => [-1, 1, 3, 4, 5, 6]

# number < atom < reference < function < port < pid < tuple < map < list < bitstring
sortedList = Enum.sort([:foo, "bar", Enum, -1, 4])
IO.inspect sortedList # => [-1, 4, Enum, :foo, "bar"]

customSort = Enum.sort([%{:val => 4}, %{:val => 1}], fn(x, y) -> x[:val] > y[:val] end)
IO.inspect customSort # => [%{:val => 4}, %{:val => 1}]

descOrder = Enum.sort([2, 3, 1], :desc)
IO.inspect descOrder # => [3, 2, 1]

uniqEle = Enum.uniq([1, 2, 3, 2, 1, 1, 1, 1, 1])
IO.inspect uniqEle # => [1, 2, 3]

uniqBy = Enum.uniq_by([%{x: 1, y: 1}, %{x: 2, y: 1}, %{x: 3, y: 3}], fn coord -> coord.y end)
IO.inspect uniqBy # => [%{x: 1, y: 1}, %{x: 3, y: 3}]

plusThree = Enum.map([1,2,3], &(&1 + 3))
IO.inspect plusThree # => [4, 5, 6]

sum = Enum.reduce([1, 2, 3, 6, 7, 8, 9, 10], 0, &(&1 + &2))
IO.puts sum # => 6

defmodule Adding do
  def plus_three(number), do: number + 3
  def add(a, b), do: a + b
end

# addThree = Enum.map([1, 2, 3, 6, 7, 8, 9, 10], fn(num) -> Adding.plus_three(num) end)
# addThree = Enum.map([1, 2, 3, 6, 7, 8, 9, 10], &Adding.plus_three(&1))
addThree = Enum.map([1, 2, 3, 6, 7, 8, 9, 10], &Adding.plus_three/1)
IO.inspect addThree # => [4, 5, 6, 9, 10, 11, 12, 13]

sum = Enum.reduce([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0, &Adding.add/2)
IO.puts sum # => 55
