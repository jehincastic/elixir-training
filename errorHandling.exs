# Elixir has three error mechanisms: errors, throws, and exits

# Errors
# Errors (or exceptions) are used when exceptional things happen in the code.
# A sample error can be retrieved by trying to add a number to an atom:
# Eg => 1 + :foo [(ArithmeticError) bad argument in arithmetic expression]
# Runtime errors can be raised
# Eg => raise "This is an error"
# Eg => raise ArgumentError, message: "invalid argument foo"
defmodule MyError do
  defexception message: "Default message"
end
# raise MyError
# raise MyError, message: "This is a custom error message"

# Errors can be rescued using the try/rescue construct:
try do
  raise MyError, message: "Custom Err"
rescue
  e in MyError ->
    IO.puts "MyError was raised"
    IO.puts e.message
  d ->
    IO.puts "Some other error was raised"
    IO.puts d.message
end

# Reraising errors
# This can be used for observability/monitoring
# Imagine you want to log that something went wrong
# try do
#   ... some code ...
# rescue
#   e ->
#     Logger.error(Exception.format(:error, e, __STACKTRACE__))
#     reraise e, __STACKTRACE__
# end

# Generally speaking, we take errors in Elixir literally:
# they are reserved for unexpected and/or exceptional situations,
# never for controlling the flow of our code.
# In case you actually need flow control constructs, throws should be used

# Throws
# In Elixir, a value can be thrown and later be caught.
# throw and catch are reserved for situations where it is not possible
# to retrieve a value unless by using throw and catch.

val = try do
  Enum.each(-50..50, fn x -> if rem(x, 13) == 0, do: throw(x) end)
  "No multiple of 13 found"
catch
  x -> "Got #{x}"
end

IO.puts val

spawn(fn -> exit(1) end)
# This sends an exit signal to the process and the process exits

try do
  exit("boom")
catch
  :exit, _ -> IO.puts "Catched exit"
end

IO.puts "Done"

# after is similar to finally in JS
# Note that if a linked process exits,
# this process will exit and the after clause will not get run.
# {:ok, file} = File.open("sample", [:utf8, :write])
# try do
#   IO.puts file, "Hello"
#   raise "oopsse"
# after
#   File.close(file)
# end

# Sometimes you may want to wrap the entire body of a function in a try construct,
# often to guarantee some code will be executed afterwards.
# In such cases, Elixir allows you to omit the try line:
defmodule RunAfter do
  def without_even_trying do
    raise "oops"
  after
    IO.puts "cleaning up!"
  end
end

# RunAfter.without_even_trying

# If an else block is present,
# it will match on the results of the try block whenever
# the try block finishes without a throw or an error.
x = 2

val = try do
  1 / x
rescue
  ArithmeticError ->
    :infinity
else
  y when y < 1 and y > -1 ->
    :small
  _ ->
    :large
end

IO.puts val
