odd? = &(rem(&1, 2) != 0)
_sum = 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum()
# sum is 7500000000

stream_sum =  1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
# stream_sum is 7500000000
# We start with a range and then multiply each element in the range by 3.
# This first operation will now create and return a list with 100_000 items.
# Then we keep all odd elements from the list, generating a new list, now with 50_000 items
# and then we sum all entries
IO.inspect stream_sum

# 1..100_000 |> Stream.map(&(&1 * 3))
# the above returns a stream data type that represents map computation over a range
# Stream<[enum: 1..100000, funs: [#Function<34.16982430/1 in Stream.map/2>]]>
# Instead of generating intermediate lists,
# streams build a series of computations that are invoked
# only when we pass the underlying stream to the Enum module.
# Streams are useful when working with large, possibly infinite, collections.

# Many functions in the Stream module accept any enumerable as an argument
# and return a stream as a result. It also provides functions for creating streams

# Stream.cycle/1 can be used to create a stream that cycles a given enumerable infinitely
# Be careful to not call a function like Enum.map/2 on such streams, as they would cycle forever
stream = Stream.cycle([1, 2, 3])
IO.inspect Enum.take stream, 10

# On the other hand, Stream.unfold/2 can be used to generate values from a given initial value:
stream = Stream.unfold("hełło", &String.next_codepoint/1)
Enum.each(stream, fn v -> IO.puts v end)

# Another interesting function is Stream.resource/3 which can be used to wrap around
# resources, guaranteeing they are opened right before enumeration and closed afterwards,
# even in the case of failures.

# stream = File.stream!("path/to/file")
# Enum.take(stream, 10)
