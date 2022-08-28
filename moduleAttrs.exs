defmodule MyModule do
  @moduledoc """
  My own module.

  ## Example

  ## Examples
    iex> MyModule.fun()
    "hello world"

  """

  @greeter "hello world"

  @doc """
  This is a simple function that returns hello world.
  """
  def fun do
    @greeter
  end

  @greeter "hola mundo"
  def second_fun, do: @greeter

  # Normally, repeating a module attribute will cause its value to be reassigned
  # the below line allows to append values to a attribute
  Module.register_attribute __MODULE__, :param, accumulate: true

  @param :foo
  @param :bar
  @param os: :unix

  def third_fun, do: @param

end


IO.puts MyModule.fun
IO.puts MyModule.second_fun
IO.puts MyModule.fun
IO.inspect MyModule.third_fun
