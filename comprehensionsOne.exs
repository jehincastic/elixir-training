IO.inspect for n <- [1, 2, 3, 4], do: n * n
# n <- [1, 2, 3, 4] [This is the generator]

values = [good: 1, good: 2, bad: 3, good: 4]
# Applies the function to elements that match the pattern
IO.inspect for {:good, val} <- values, do: val * 2

# Applies the function to elements that match the filter
IO.inspect for n <- 0..5, rem(n, 3) == 0, do: n * n

dirs = ['/home/jehincastic']

val = for dir <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file),
    File.regular?(path) do
  File.stat!(path).size
end

IO.inspect val

IO.inspect for i <- [:a, :b, :c], j <- [1, 2], do:  {i, j}
# [a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]

pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
IO.inspect for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}


IO.puts for <<c <- " hello world ">>, c != ?\s, into = "", do: <<c>>
IO.inspect for {key, val} <- %{"a" => 1, "b" => 2}, into: %{}, do: {key, val * val}

stream = IO.stream(:stdio, :line)
for line <- stream, into: stream do
  String.upcase(line) <> "\n"
end
