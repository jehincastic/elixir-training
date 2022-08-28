# Protocols are a mechanism to achieve polymorphism in Elixir
# when you want behavior to vary depending on the data type.
# We are already familiar with one way of solving this type of problem:
# via pattern matching and guard clauses.
# Consider a simple utility module that would tell us the type of input variable

defmodule Utility do
  def get_type(val) when is_binary(val), do: "String"
  def get_type(val) when is_integer(val), do: "Integer"
  def get_type(val) when is_number(val), do: "Number"
end

IO.puts Utility.get_type("hello") # String
IO.puts Utility.get_type(123) # Integer
IO.puts Utility.get_type(123.23) # Number

# dispatching on a protocol is available to any data type
# that has implemented the protocol

defprotocol UtilityProto do
  @spec type(t) :: String.t
  def type(val)
end

defimpl UtilityProto, for: BitString do
  def type(_val), do: "String"
end

defimpl UtilityProto, for: Integer do
  def type(_val), do: "Integer"
end

defimpl UtilityProto, for: Number do
  def type(_val), do: "Number"
end

IO.puts "Protocol"
IO.puts UtilityProto.type("hello") # String
IO.puts UtilityProto.type(123) # Integer

defmodule User do
  defstruct [:name, :age]
end

defprotocol CalcSize do
  @doc """
  Calculates the size (not the length) of the given data structure.
  """
  # fallback implementation allow to call Any implementation
  @fallback_to_any true
  def size(data)
end

defimpl CalcSize, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl CalcSize, for: Map do
  def size(string), do: map_size(string)
end

defimpl CalcSize, for: Tuple do
  def size(string), do: tuple_size(string)
end

defimpl CalcSize, for: MapSet do
  def size(set), do: MapSet.size(set)
end

defimpl CalcSize, for: User do
  def size(_user), do: 2
end

defimpl CalcSize, for: Any do
  def size(_user), do: 2200
end

# Elixir allows us to derive a protocol implementation based on the Any implementation.
# in order to use such implementation we would need to tell our struct to explicitly derive the Size

defprotocol CalcSizeNew do
  @doc """
  Calculates the size (not the length) of the given data structure.
  """
  def size(data)
end

defimpl CalcSizeNew, for: Any do
  def size(_), do: 1100
end

defmodule OtherUser do
  @derive [CalcSizeNew]
  defstruct [:name, :age]
end

defmodule Main do
  def main do
    IO.puts CalcSize.size("hello") # 5
    IO.puts CalcSize.size({1, 2, 3}) # 3
    IO.puts CalcSize.size(%{a: 1, b: 2}) # 2

    # (Protocol.UndefinedError) protocol CalcSize not implemented for [1, 2, 3] of type List
    # IO.puts CalcSize.size([1, 2, 3])

    # It's possible to implement protocols for all Elixir data types:
    # Atom, BitString, Float, Function, Integer, List, Map, PID, Port, Reference, Tuple

    IO.puts CalcSize.size(%{})
    IO.puts CalcSize.size(MapSet.new([1, 2, 3, 3, 4, 5]))
    IO.puts CalcSize.size(%User{name: "John", age: 27})
    IO.puts CalcSize.size([1, 2, 3])

    usr = %OtherUser{name: "John", age: 27}
    IO.puts CalcSizeNew.size(usr)

  end
end

Main.main()
