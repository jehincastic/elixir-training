sum = fn (a, b) -> a + b end
IO.puts sum.(100, 200) # => 300

sum = &(&1 + &2 + &3)
IO.puts sum.(1, 2, 3) # => 6

handleResult = fn
  {:ok, result} -> "Handled result: #{result}"
  {:error} -> "Handled error"
  {:error, error} -> "Handled error: #{error}"
  _ -> "Catch all"
end

IO.puts handleResult.({:ok, "Hello"}) # => "Handled result: Hello"
IO.puts handleResult.({:error, "Uh oh!"}) # => "Handled error: Uh oh!"
IO.puts handleResult.({:error}) # => "Handled error"
IO.puts handleResult.({:catchApp}) # => "Catch all"

defmodule Greeter do
  def greting(name), do: "Hello " <> name
  def hello(name) do
    "Hello #{name}"
  end
end

IO.puts Greeter.hello("World") # => "Hello World"
IO.puts Greeter.greting("World") # => "Hello World"

defmodule Length do
  def of([]), do: 0
  def of([_ | tail]), do: 1 + of(tail)
  def of(_), do: "Invalid Value"
end

IO.puts Length.of([]) # => 0
IO.puts Length.of([1, 2, 3]) # => 3
IO.puts Length.of([1, 2, 3, 4, 5]) # => 5
IO.puts Length.of(5) # => 5

defmodule Greeter2 do
  def hello(), do: "Hello User"
  def hello(name), do: "Hello #{name}"
  def hello(nameOne, nameTwo), do: "Hello #{nameOne} and #{nameTwo}"
end

IO.puts Greeter2.hello() # => "Hello User"
IO.puts Greeter2.hello("World") # => "Hello World"
IO.puts Greeter2.hello("World", "Earth") # => "Hello World and Earth"

defmodule Greeter1 do
  def hello(%{name: person_name}) do
    IO.puts "Hello #{person_name}"
  end
end

Greeter1.hello(%{name: "Sam"}) # => "Hello World"

fred = %{name: "Fred", age: "95", favorite_color: "Taupe"}
Greeter1.hello(fred)

defmodule Greeter3 do
  def hello(%{name: person_name} = person) do
    IO.puts "Hello, " <> person_name
    IO.inspect person
  end
end

# defmodule Greeter3 do
#   def hello(person = %{name: person_name}) do
#     IO.puts "Hello, " <> person_name
#     IO.inspect person
#   end
# end
# This also works
# Functions pattern-match the data passed in to each of its arguments independently.
# We can use this to bind values to separate variables within the function

Greeter3.hello(fred)
# => "Hello, Fred
# => {:age=>"95", :favorite_color=>"Taupe", :name=>"Fred"}

defmodule GreeterPrivate do
  def hello(name), do: phrase() <> name
  defp phrase, do: "Hello, "
end

IO.puts GreeterPrivate.hello("World") # => "Hello, World"
# IO.puts GreeterPrivate.phrase() -> Cannot access private method

defmodule GreeterModule do

  def multiLangHello(name, lang \\ "en") do
    phrase(lang) <> name
  end

  def helloWithLang(name, lang \\ "en")

  def helloWithLang(name, lang) when is_list(name) do
    names = Enum.join(name, ",")

    phrase(lang) <> names
  end

  def helloWithLang(name, lang) when is_binary(name) do
    phrase(lang) <> name
  end

  def hello(names) when is_list(names) do
    names = Enum.join(names, ", ")

    hello(names)
  end

  def hello(name) when is_binary(name) do
    phrase() <> name
  end

  defp phrase, do: "Hello, "
  defp phrase("en"), do: "Hello, "
  defp phrase("es"), do: "Hola, "
end

IO.puts GreeterModule.hello ["Desmond", "Tony"]
IO.puts GreeterModule.hello "Ronald"
IO.puts GreeterModule.multiLangHello("Desmond")
IO.puts GreeterModule.multiLangHello("Miles", "es")
IO.puts GreeterModule.helloWithLang("ABC")
IO.puts GreeterModule.helloWithLang("ABC", "es")
