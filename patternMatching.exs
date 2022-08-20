list = [1, 2, 3]
[1, 2, 3] = list

# [] = list -> throws an error

[1 | tail] = list

IO.inspect tail # => [2, 3]

# [2 | _] = list -> throws an error
# [** (MatchError) no match of right hand side value: [1, 2, 3]]

{:ok, value} = {:ok, "Successful!"}
IO.puts value # => "Successful!"

# {:ok, value} = {:error} -> throws an error
# [** (MatchError) no match of right hand side value: {:error}]

# pin operatior "^"
# Patern matches the value in a variable
x = 1
^x = 1

IO.puts x # => 1

key = "hello"
%{^key => value} = %{"hello" => "world"}
IO.puts value # => "world"

# %{^key => value} = %{:hello => "world"} -> throws an error

greeting = "Hello"
greet = fn
  (^greeting, name) -> "Hi #{name}"
  (greeting, name) -> "#{greeting}, #{name}"
end

IO.puts greet.("Hola", "John") # => "Hola, John"
IO.puts greet.("Hello", "John") # => "Hi John"
