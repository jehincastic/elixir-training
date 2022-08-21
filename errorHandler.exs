try do
  raise "Oh no!"
rescue
  e in RuntimeError -> IO.puts("An error occurred: " <> e.message)
end

IO.puts "After the error"

# try do
#   opts
#   |> Keyword.fetch!(:source_file)
#   |> File.read!()
# rescue
#   e in KeyError -> IO.puts("missing :source_file option")
#   e in File.Error -> IO.puts("unable to read source file")
# end


try do
  raise "Oh no!"
rescue # catch
  e in RuntimeError -> IO.puts("An error occurred: " <> e.message)
after # finally
  IO.puts "The end!"
end

defmodule ExampleError do
  defexception message: "an example error has occurred"
  # Create a new error with default message
end

try do
  raise ExampleError
rescue
  e in ExampleError -> IO.puts e.message
end

# Catch can be used with throw
try do
  for x <- 0..10 do
    if x == 5, do: throw(x)
    IO.puts(x)
  end
catch
  x -> IO.puts "Caught: #{x}"
end
IO.puts "After the error"

# The final error mechanism Elixir provides us with is exit.
# Exit signals occur whenever a process dies and
# are an important part of the fault tolerance of Elixir.

# exit("oh no")

# While it is possible to catch an exit with try/catch doing so is extremely rare.
# In almost all cases it is advantageous to let the supervisor handle the process

try do
  exit "oh no!"
catch
  :exit, _ -> IO.puts "exit blocked"
end
