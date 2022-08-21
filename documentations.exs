# Outputs 'Hello, chum.' to the console.
IO.puts("Hello, " <> "chum.")

defmodule Greeter do
  @moduledoc """
  Provides a function `hello/1` to greet a human
  """

  @doc """
  Prints a hello message.

  ## Parameters

    - name: String that represents the name of the person.

  ## Examples

      iex> Greeter.hello("Sean")
      "Hello, Sean"

      iex> Greeter.hello("pete")
      "Hello, pete"

  """
  def hello(name) do
    "Hello, " <> name
  end
end

Greeter.hello("chum")
