# To import specific functions and macros, we must provide the name/arity pairs
# to :only and :except. Let’s start by importing only the last/1 function:
# import List, only: [last: 1]

# In addition to the name/arity pairs there are two special atoms, :functions and :macros
# which import only functions and macros respectively:
# import List, only: :functions
# import List, only: :macros

# If we want to import functions rather than aliasing the module we can use import
import List

defmodule Sayings.Greetings do
  def basic(name), do: "Hola, #{name}"
end

defmodule Sayings.GoodMorning do
  def greet(name), do: "Good Morning, #{name}"
end

defmodule Sayings.GoodEvening do
  def greet(name), do: "Good Evening, #{name}"
end

defmodule Example do

  # alias the Sayings.Greetings module to Greetings
  alias Sayings.{Greetings, GoodEvening}
  alias Sayings.GoodMorning, as: Gm

  # It is important to note there are reserved attributes in Elixir.
  # The three most common are:
  # moduledoc — Documents the current module.
  # doc — Documentation for functions and macros.
  # behaviour - Use an OTP or user-defined behaviour.
  @greeting "Hello"

  def greeting(name) do
    ~s(#{@greeting} #{name}.)
  end

  def basic_greeting(name) do
    Greetings.basic(name)
  end

  def good_morning(name) do
    Gm.greet(name)
  end

  def good_evening(name) do
    GoodEvening.greet(name)
  end
end

defmodule Example.Greetings do
  def morning(name) do
    "Good morning #{name}."
  end

  def evening(name) do
    "Good night #{name}."
  end
end

defmodule Example.User do
  # creates a struct with the given fields and default values
  # @derive {Inspect, only: [:name]} # This makes only the name field inspectable.
  # This makes all fields inspectable except permission.
  @derive {Inspect, except: [:permissions]}
  defstruct name: "Sean", roles: [], permissions: []
end

defmodule HelloWithParams do
  defmacro __using__(opts) do
    greeting = Keyword.get(opts, :greeting, "Hola")

    quote do
      def hello(name), do: "#{unquote(greeting)} #{name}!"
    end
  end
end

defmodule Hello do
  defmacro __using__(_opts) do
    quote do
      def hello(name), do: "Hello, #{name}!"
    end
  end
end

defmodule UsingHello do
  use Hello
  # With the use macro we can enable another module to modify our current module’s definition.
  # When we call use in our code we’re actually invoking the __using__/1 callback
  # defined by the provided module.
  # The result of the __using__/1 macro becomes part of our module’s definition.
end

defmodule UsingHelloWithParams do
  use HelloWithParams, greeting: "Hello,"
end

defmodule Main do

  # We could use require to tell Elixir you’re going to use macros from another module.
  # The slight difference with import is that it allows using macros,
  # but not functions from the specified module
  # require SuperMacros

  # SuperMacros.do_stuff
  # If we attempt to call a macro that is not yet loaded Elixir will raise an error.

  def main do
    IO.puts Example.greeting "Sean"
    IO.puts Example.Greetings.morning "Sean"
    steve = %Example.User{name: "Desmond"}
    IO.inspect steve
    steve = %{steve | name: "Steve"}
    IO.puts steve.name
    steve = %{steve | name: "Steve Joe", roles: [:admin, :user], permissions: [:create, :read, :update, :delete]}
    IO.puts steve.name
    IO.inspect steve.roles
    IO.inspect steve.permissions
    IO.puts Example.basic_greeting "Sean"
    IO.puts Example.good_morning "Sean"
    IO.puts Example.good_evening "Sean"
    IO.puts last([1, 2, 3]) # using the last function from List module
    IO.puts UsingHello.hello "Sean"
    IO.puts UsingHelloWithParams.hello "Sean"
  end
end

Main.main()
