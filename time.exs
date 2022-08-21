IO.puts Time.utc_now
IO.puts ~T[19:39:31.056226]
t = ~T[19:39:31.056226]
IO.puts t.hour
IO.puts t.minute
IO.puts t.second

IO.puts Date.utc_today
IO.puts ~D[2028-10-21]

{:ok, date} = Date.new(2020, 12, 12)
IO.puts Date.day_of_week date
IO.puts Date.leap_year? date

# Native DateTime does not support timezones
IO.puts NaiveDateTime.utc_now
IO.puts NaiveDateTime.add(~N[2018-10-01 00:00:14], 30)

IO.inspect DateTime.from_naive(~N[2016-05-24 13:26:08.003], "Etc/UTC")
