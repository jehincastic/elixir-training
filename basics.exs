_random = :crypto.strong_rand_bytes 3

IO.puts 5+5 == "10" # => false
IO.puts :true == true # => true (booleans are atoms in elixir)
IO.puts 10 / 2 # => 5.0 a float
IO.puts div(10, 2) # => 5 a int
IO.puts rem(10, 3) # => 1 a int (there is no % in elixir)

IO.puts "Conditional expressions"

IO.puts nil || 120 # => 120
IO.puts nil && 120 # => nil
IO.puts false && 120 # => false
IO.puts false || nil # => nil
IO.puts nil || false  # => false
IO.puts nil || false || 123 # => 123
IO.puts 0 || 123 # => 0
IO.puts "" || 123 # => ""
IO.puts nil === false # => false
IO.puts nil === "" # => false
IO.puts true and 42 # => 42 (for "and" & "or" the first value must be boolean)
IO.puts true or 42 # => true
IO.puts not true # => false ("not" only supports boolean)

# number < atom < reference < function < port < pid < tuple < map < list < bitstring
name = "John"
IO.puts "Hi #{name}"
IO.puts "Hi " <> name <> "!"
