val = IO.gets "Your name?\n"

IO.puts "Hello, #{val}" # Wrties to stdout
IO.puts(:stderr, "Hello, #{val}") # Writes to stderr

{:ok, file} = File.open("./hello.txt", [:write])
IO.binwrite(file, "Hello, world")
File.close(file)
case File.read("./hello.txt") do
  {:ok, data} ->
    IO.puts data
  {:error, reason} ->
    IO.puts "Error: #{reason}"
end

IO.puts Path.join("foo", "bar")
IO.puts Path.expand("~/hello")

IO.puts(["apple", [",", "banana", [",", "lemon"]]])
IO.puts(["apple", ?,, "banana", ?,, "lemon"])
IO.puts([?O, ?l, ?á, ?\s, "Mary", ?!])
