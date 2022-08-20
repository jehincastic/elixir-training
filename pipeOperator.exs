name = "Elixir rocks"

IO.inspect String.split(name)
name |> String.split() |> IO.inspect()
name |> String.upcase |> String.split |> IO.inspect
name |> String.ends_with?("s") |> IO.puts

name = "Elixir-rocks"
name |> String.split("-") |> IO.inspect
