IO.puts "Lists"

list = [3.14, :pie, "Apple"]

IO.inspect list # => [3.14, :pie, "Apple"]

IO.puts hd list # => returns the first element of the list
IO.puts hd tl list # => tl returns the elements except first one of the list
IO.inspect tl list # => [:pie, "Apple"]

list = ["π" | list] # => concatenates the list with the first element of the list
IO.puts hd list # => "π"

list = list ++ ["Cherry"] # => concatenates the list with the last element of the list
IO.inspect list # => ["π", 3.14, :pie, "Apple", "Cherry"]

list = list ++ ["A", "B", "C"]
IO.inspect list # => ["π", 3.14, :pie, "Apple", "Cherry", "A", "B", "C"]

list = list -- ["A", "B", "C", "D", "E", "F"] # => removes the elements from the list if not present then omitted
IO.inspect list # => ["π", 3.14, :pie, "Apple", "Cherry"]

IO.inspect [1,1,2,2,3,2,3] -- [1,2,3,2] # => [1,2,3]
IO.inspect [2.0] -- [2] # => [2.0]

[head | tail] = [1,2,3,4,5]
IO.puts head # => 1
IO.inspect tail # => [2,3,4,5]

IO.puts "Tuples"
# => tuples are stored contiguously in memory
# => This makes accessing their length fast but modification expensive
# => the new tuple must be copied entirely to memory
# => tuples are the only collection that is not enumerable

tuple = {3.14, :pie, "Apple"}

IO.inspect tuple # => {3.14, :pie, "Apple"}

_val = File.read("./basics.exs")
# IO.inspect val => {:ok, <File Content>}

val = File.read("./basics-not-found.exs")
IO.inspect val # => {:error, :enoent}

IO.puts "Keyword Lists"
# => Keys in keyword lists are atoms
# => Keys are ordered
# => Keys do not have to be unique

kList = [foo: "bar", apple: "3.14", hello: "world", apple: "π"]
IO.inspect kList # => [:foo => "bar", :hello => "world"]
IO.puts kList[:apple] # => "3.14"
IO.puts kList[:hello] # => "world"

IO.inspect [{:foo, "Bar"}, {:hello, "World"}]

IO.puts "Maps"
# => Keys can be any type
# => Keys are un-ordered
# => Keys will be unique [if a key ovewritten new value replaces old value]

IO.inspect %{}

map = %{:name => "Desmond", :age => 30}

IO.inspect map # => %{:age: 30, :name: "Desmond"}

IO.puts map[:name] # => "Desmond"

map = %{ "hello" => "World" }
IO.inspect map # => {"hello" => "World"}

key = "hello"
IO.puts map[key] # => "World"

map = %{ key => "World" }
IO.inspect map # => {"hello" => "World"}

map2 = %{ "hello" => "World" }

IO.puts map === map2 # => true

map = %{ hello: "World" } # => here the key is an atom
IO.inspect map == map2 # => false

IO.puts map.hello # => . notation is used to access the value of the map if the key is an atom
IO.puts map2["hello"]

map = %{foo: "bar", hello: "world"}
map = %{ map | foo: "baz" } # => this can be used only to update keys from map
IO.inspect map # => {:foo => "baz", :hello => "world"}
# map = %{ map | abc: "baz" } # => this line throws an error

map = Map.put(map, :abc, "baz") # => this can be used to update and add keys to map
map = Map.put(map, :foo, "bar")
IO.inspect map # => {:foo => "bar", :hello => "world", :abc => "baz"}

map = Map.delete(map, :foo) # => this can be used to delete keys from map
IO.inspect map # => {:hello => "world", :abc => "baz"}
IO.puts map[:a] # => nil
# IO.puts map.a # => accessing atom key via . will throw an error if the key is not present

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

IO.puts "John's age is #{users[:john].age}" # => John's age is 27

# IO.puts users[:john].ages # => this throws an error (beacuse the acces is based on Strict access)
IO.puts users[:john][:ages] # => this returns nil (the brackets denotes Dynamic access)
IO.puts users[:johns][:ages] # => this returns nil

users = put_in(users[:john].age, 31) # => this can be used to update the value of the key
IO.puts users[:john].age # => 31

users = update_in(
  users[:mary].languages,
  fn languages ->
    List.delete(languages, "Clojure")
  end
)

IO.inspect users[:mary]
