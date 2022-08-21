expression = ~c/2 + 7 = #{2 + 7}/
IO.puts expression #=> 2 + 7 = 9

expression = ~C/2 + 7 = #{2 + 7}/
IO.puts expression #=> 2 + 7 = #{2 + 7}

re = ~r/elixir/
IO.puts "Elixir" =~ re
IO.puts "elixir" =~ re

re = ~r/elixir/i
IO.puts "Elixir" =~ re
IO.puts "elixir" =~ re

string = "100_000_000"
IO.inspect Regex.split(~r/_/, string)

IO.puts ~s/welcome to elixir #{String.capitalize "SCHOOL"}/
IO.puts ~S/welcome to elixir #{String.downcase "SCHOOL"}/

IO.inspect ~w/i love #{'e'}lixir school/
IO.inspect ~W/i love #{'e'}lixir school/

IO.puts NaiveDateTime.from_iso8601("2015-01-23 23:50:07") == {:ok, ~N[2015-01-23 23:50:07]}
IO.puts DateTime.from_iso8601("2015-01-23 23:50:07Z") == {:ok, ~U[2015-01-23 23:50:07Z], 0}
IO.puts DateTime.from_iso8601("2015-01-23 23:50:07-0600") == {:ok, ~U[2015-01-24 05:50:07Z], -21600}

defmodule MySignals do
  def signal_p(string, []), do: String.upcase(string)
end

# To use this module, you must import it in your Elixir file:
# import MySignals
# IO.puts ~p/elixir school/ => ELIXIR SCHOOL
