# This returns UNICODE codepoints
IO.inspect String.to_charlist "Ø"

# This deals with raw bytes
IO.inspect :binary.bin_to_list "Ø"

:io.format("Pi is approximately given by:~10.3f~n", [:math.pi])
IO.puts to_string :io_lib.format("Pi is approximately given by:~10.3f~n", [:math.pi])
IO.puts Base.encode16(:crypto.hash(:sha256, "Elixir"))

# The modules ets and dets handle storage of large data structures in memory or on disk respectively.
# ETS lets you create a table containing tuples.
# By default, ETS tables are protected, which means only the owner process
# may write to the table but any other process can read.
# ETS has some functionality to allow a table to be used as a simple database,
# a key-value store or as a cache mechanism.
# The functions in the ets module will modify the state of the table as a side-effect.

IO.puts "ETS"

table = :ets.new(:ets_test, [])
:ets.insert(table, {"China", 1_374_000_000})
:ets.insert(table, {"India", 1_284_000_000})
:ets.insert(table, {"USA", 322_000_000})

# IO.inspect :ets.i(table)

angle_45_deg = :math.pi() * 45.0 / 180.0
IO.puts :math.sin(angle_45_deg)
IO.puts :math.exp(55.0)
IO.puts :math.log(7.694785265142018e23)

IO.puts "Queue"
q = :queue.new
q = :queue.in("A", q)
q = :queue.in("B", q)

{value, q} = :queue.out(q)
IO.inspect value

{value, q} = :queue.out(q)
IO.inspect value

{value, _q} = :queue.out(q)
IO.inspect value


IO.puts "Random Module"

IO.puts :rand.uniform()
_ = :rand.seed(:exs1024, {123, 123534, 345345})
IO.puts :rand.uniform()
IO.puts :rand.uniform(6)
