defmodule Example do
  def timed(fun, args) do
    {time, result} = :timer.tc(fun, args)
    IO.puts "Time: #{time} μs"
    IO.puts "Result: #{result}"
  end
end

Example.timed(fn (n) -> (n * n) * n end, [100])
