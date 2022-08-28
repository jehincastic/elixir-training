defmodule User do
  # create a struct
  # with keys name, age, and active
  # with default values of "John", 27, and nil respectively
  # defstruct name: "John", age: 27
  # Enforce certain keys have to be specified when creating the struct
  @enforce_keys [:id]
  defstruct [:email, :id, name: "John", age: 27]
end

defmodule Main do
  def main do
    user = %User{id: 1}
    IO.puts "User name is #{user.name}"
    user = %{user | age: 28}
    IO.puts "User age is #{user.age}"
    %User{name: nme} = user
    IO.puts "User name is #{nme}"
    IO.puts is_map(user) # true
    IO.puts is_struct(user) # true
    IO.puts user.__struct__ # Elixir.User
    jane = Map.put(%User{id: 2}, :name, "Jane")
    jane = Map.merge(jane, %User{age: 32, id: 2})
    IO.inspect jane
    IO.inspect Map.keys(jane)
    IO.inspect Map.values(jane)
  end
end

Main.main()
