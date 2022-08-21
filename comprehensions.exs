# Using << >> syntax we are saying to the compiler that the elements inside those symbols are bytes
import Integer

list = [1, 2, 3, 4, 5]

newList = for x <- list, do: x*x

IO.inspect newList
# [1, 4, 9, 16, 25]

IO.inspect for {_key, val} <- [one: 1, two: 2, three: 3], do: val

IO.inspect for {k, v} <- %{"a" => "A", "b" => "B"}, do: {k, v}

IO.inspect for <<c <- "hello">>, do: <<c>>

IO.inspect for {:ok, val} <- [ok: "Hello", error: "Unknown", ok: "World"], do: val

list = [1, 2, 3, 4]
val = for n <- list, times <- 1..n do
  # String.duplicate("*", times)
  "#{n} - #{times}"
end

IO.inspect val

for n <- list, time <- 1..n, second_time <- 1..time do
  IO.puts "#{n} - #{time} - #{second_time}"
end

# Filters only even numbers
IO.inspect for x <- 1..10, is_even(x), do: x

# Filters only even numbers divisible by 3
IO.inspect for x <- 1..100,
  is_even(x),
  rem(x, 3) == 0, do: x

# into accepts any structure that implements the Collectable protocol
IO.inspect for {k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k, v}
# %{one: 1, three: 3, two: 2}

IO.puts for c <- [72, 101, 108, 108, 111], into: "", do: <<c>>
# Hello
