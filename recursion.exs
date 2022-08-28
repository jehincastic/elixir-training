defmodule Recursion do
  def print_multi(msg, n) when n > 0 do
    IO.puts msg
    print_multi(msg, n - 1)
  end

  def print_multi(_msg, 0) do
    :ok
  end

  def sum_list(list, acc \\ 0)

  def sum_list([head | tail], acc) do
    sum_list(tail, acc + head)
  end

  def sum_list([], acc) do
    acc
  end

  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

IO.puts Recursion.print_multi("Hello", 3)
IO.puts Recursion.sum_list([1,2,3,4,5])
IO.inspect Recursion.double_each([1,2,3,4,5])
IO.puts Enum.reduce([1, 2, 3, 4, 5], 0, &+/2)
IO.inspect Enum.map([1, 2, 3, 4, 5], &(&1 * 2))
