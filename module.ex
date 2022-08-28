defmodule Math do
  def sum(a, b) do
    IO.puts "Adding Two Value #{a} and #{b}"
    result = do_sum(a, b)
    IO.puts "Result is #{result}"
    result
  end

  defp do_sum(a, b) do
    a + b
  end

  # def is_zero?(0) do
  #   true
  # end

  # def is_zero?(a) when is_integer(a) do
  #   false
  # end

  def zero?(0), do: true
  def zero?(a) when is_integer(a), do: false
end

# use `elixirc {file_name}` to compile the file to BEAM bytecode

defmodule Concat do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end
