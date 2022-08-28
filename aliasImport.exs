# Alias the module so it can be called as Bar instead of Foo.Bar
# alias Foo.Bar, as: Bar

# Require the module in order to use its macros
# require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
# import Foo

# Invokes the custom code defined in Foo as an extension point
# use Foo

# Alias
defmodule Stats do
  # alias MyApp.{Foo, Bar, Baz} -> to alias multiple modules
  alias Math.List, as: List
  # same as -> alias Math.List
  # here we are aliasing the module, and can call it as List
  # The original List can be still accessed by Elixir.List

  def fun do
    IO.puts List
    IO.puts Elixir.List.first([1, 2, 3])
  end
end

Stats.fun()

# Require
# Elixir provides macros as a mechanism for meta-programming
# (writing code that generates code).
# Macros are expanded at compile time.
# Public functions in modules are globally available,
# but in order to use macros, you need to opt-in by requiring the module
# they are defined in.

require Integer
IO.puts Integer.is_even(2)

# Import
# We use import whenever we want to access functions or macros from other modules
# without using the fully-qualified name.
# Note we can only import public functions,
# as private functions are never accessible externally.

IO.inspect List.duplicate(:ok, 3)

import List, only: [duplicate: 2]
IO.inspect duplicate(:ok, 3)

# Use
# The use macro is frequently used as an extension point.
# This means that, when you use a module FooBar,
# you allow that module to inject any code in the current module,
# such as importing itself or other modules, defining new functions,
# setting a module state, etc.

# defmodule AssertionTest do
#   use ExUnit.Case, async: true

#   test "always pass" do
#     assert true
#   end
# end

# defmodule Example do
#   use Feature, option: :value
# end
# => The above code is compiled to:
# defmodule Example do
#   require Feature
#   Feature.__using__(option: :value)
# end
