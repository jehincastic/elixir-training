regex = ~r/foo|bar/
IO.puts "foo" =~ regex # true
IO.puts "bat" =~ regex # false
IO.puts "HELLO" =~ ~r/Hello/i # true
IO.puts "https://elixir-lang.org" =~ ~r(https?://) # true

val = ~s(this is a string with double and single quotes: " ' )
IO.puts val
IO.puts "Is binary => #{is_binary(val)}"

val = ~c(this is a string with double and single quotes: " ' )
IO.puts val
IO.puts "Is list => #{is_list(val)}"

IO.inspect ~w(foo bar bat)
# ["foo", "bar", "bat"]
IO.inspect ~w(foo bar bat)a
#  here "a" is a modifier that denotes the output type as atom
# c -> charlist
# s -> string
# [:foo, :bar, :bat]

IO.puts ~s(String with escape codes \x26 #{"inter" <> "polation"})
IO.puts ~S(String without escape codes \x26 without #{interpolation})
IO.puts ~s"""
this is
a heredoc string
"""

day = ~D[2018-01-01]
IO.puts "#{day.day}-#{day.month}-#{day.year}"
t = ~T[23:00:07.0]
IO.puts "#{t.hour}:#{t.minute}:#{t.second}"

# NaiveDateTime
# Why is it called naive? Because it does not contain timezone information
ndt = ~N[2019-10-31 23:00:07]
IO.inspect ndt

dt = ~U[2019-10-31 19:59:03Z]
%DateTime{minute: minute, time_zone: time_zone} = dt
IO.puts "#{minute} #{time_zone}"

# ~r/foo/i -> is equvialent to calling the below
# sigil_r(<<"foo">>, 'i')

defmodule MySigils do
  def sigil_i(string, []) do
    String.to_integer(string)
  end
  def sigil_i(string, [?n]) do
    -String.to_integer(string)
  end
end

defmodule Main do
  import MySigils
  IO.puts ~i(123)
  IO.puts ~i(123)n
end
