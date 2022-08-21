# Elixir strings are nothing but a sequence of bytes. Let’s look at an example:
# Using << >> syntax we are saying to the compiler that the elements inside those symbols are bytes
string = <<104,101,108,108,111>>

IO.puts string

IO.puts <<104, 101, 197, 130, 197, 130, 111>>

# You can get a character’s code point by using ?
IO.puts ?Z

string = "\u0061\u0301" # á

IO.puts string

IO.inspect String.codepoints string # => ["a", "́"]
IO.inspect String.graphemes string # => ["á"]

IO.puts String.length "Hello"
IO.puts String.replace("Hello", "e", "a")
IO.puts String.replace("Hello", "l", <<197, 130>>)
IO.puts String.duplicate("No ", 3) <> "Please God No"
IO.inspect String.split("Hello World", " ")
