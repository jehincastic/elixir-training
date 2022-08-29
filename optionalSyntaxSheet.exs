IO.puts length([1, 2, 3]) == length [1, 2, 3]

val = if true do
  :this
else
  :that
end

# Same as above
# if true, do: :this, else: :that
# if true, [do: :this, else: :that]

IO.puts val

defmodule Call do
  def this do
    IO.puts "this"
  end
  def that do
    IO.puts "that"
  end
end

IO.puts "------"

variable? = fn () -> true end
if variable?.() do
  Call.this()
else
  Call.that()
end

# The above is the same as:
# if variable?.(), do: Call.this(), else: Call.that()
# if variable?.(), [do: Call.this(), else: Call.that()]
# if variable?.(), [{:do, Call.this()}, {:else, Call.that()}]
# if(variable?.(), [{:do, Call.this()}, {:else, Call.that()}])

defmodule MathMod do
  def add(a, b) do
    a + b
  end
end

# The above is the same as:
# defmodule(MathMod, [
#   {:do, def(add(a, b), [{:do, a + b}])}
# ])
