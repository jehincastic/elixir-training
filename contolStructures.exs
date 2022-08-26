import Integer

if String.valid?("") do
  IO.puts "String is valid"
else
  IO.puts "String is not valid"
end

if "a string value" do
  IO.puts "Truthy"
end

unless is_integer("hello") do
  IO.puts "Not an Int"
end

map = {:ok, "Hello World"}

case map do
  {:ok, result} -> IO.puts result
  {:error} -> IO.puts "Uh oh!"
  _ -> IO.puts "Catch all"
end

# case :even do
#   :odd -> "Odd"
# end
# the above line throws an error because there is no catch all case

val = case :even do
  :odd -> "Odd"
  _ -> "Even"
end

IO.puts val

pie = 3.14

val = case "cherry pie" do
  ^pie -> "Not so tasty"
  pie -> "I bet #{pie} is tasty"
end

IO.puts val

val = case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Won't match"
end

IO.puts val

val = cond do
  2 + 2 == 5 -> "2 + 2 is 5"
  2 * 2 == 3 -> "2 * 2 is 3"
  1 + 1 == 2 -> "1 + 1 is 2"
  true -> "No match"
end

IO.puts val

user = %{first: "Sean", last: "Callan"}

val = with {:ok, first} <- Map.fetch(user, :first),
  {:ok, last} <- Map.fetch(user, :last),
    do: last <> ", " <> first

IO.puts val # => "Callan, Sean"

user = %{first: "Sean"}
val = with {:ok, first} <- Map.fetch(user, :first),
  {:ok, last} <- Map.fetch(user, :last),
    do: last <> ", " <> first

IO.puts val # => :error
IO.inspect Map.fetch(user, :last)  === :error

m = %{a: 1, c: 3}

a = with {:ok, number} <- Map.fetch(m, :a),
  true <- is_even(number) do
    IO.puts "#{number} divided by 2 is #{div(number, 2)}"
    :even
  else
    :error ->
      IO.puts("We don't have this item in map")
      :error

    _ ->
      IO.puts("It is odd")
      :odd
end

IO.inspect a

x = 1

if true do
  x = x + 1 # this does not update the value of x in the outer scope
end

# To update the value of x in the outer scope, we need to use this
x = if true do
  x + 1
else
  x
end
