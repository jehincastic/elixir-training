# What makes IO.inspect(item, opts \\ []) really useful in debugging
# is that it returns the item argument passed to it without affecting
# the behavior of the original code.

(1..10)
|> IO.inspect
|> Enum.map(fn x -> x * 2 end)
|> IO.inspect
|> Enum.sum
|> IO.inspect

[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum

defmodule MyModule do
  def some_fun(a, b, c, label \\ "Input Params") do
    IO.inspect binding(), label: label
  end
  def some_fun(a, b) do
    IO.inspect binding(), label: "Input Params"
  end
end

MyModule.some_fun(1, 2, 3) # -> [a: 1, b: 2, c: 3, label: "Input Params"]
MyModule.some_fun(1, 2) # -> [a: 1, b: 2]
