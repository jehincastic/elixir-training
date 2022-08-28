# creates a new process in elixir
pid = spawn(fn -> 1 + 2 end)
IO.puts "Created process"
IO.inspect pid
IO.puts Process.alive?(pid)
IO.puts "Main process"
IO.inspect self()
IO.puts Process.alive?(self())

# Sends the tuple {:hello, self()} to the process pid (here main process)
# it puts the message in the recipient’s mailbox and continues
send(self(), {:hello, "world"})

# It flushes and prints all the messages in the mailbox. works only in iex
# flush()

receive do
  {:hello, val} ->
    IO.puts val
  _ ->
    IO.puts "Nothing"
  # After waiting for 1000 milliseconds, the receive block will timeout and the code will continue
  after
    1000 ->
      IO.puts "Nothing after 1 second"
end

# This throws an error inside the process
# This does not affect the main process since both are not linked
spawn(fn -> raise "oops" end)
:timer.sleep(2000)
IO.puts "Main process"
IO.inspect self()

# This throws an error inside the process
# This affects the main process since both are linked
# The log "Main process" will not printed as the main process will crash

# spawn_link(fn -> raise "oops" end)
# :timer.sleep(2000)
# IO.puts "Main process"

# Tasks
# Tasks build on top of the spawn functions to provide better error reports and introspection
Task.start(fn -> raise "oops" end)
:timer.sleep(2000)
IO.puts "Main process"

# Instead of spawn/1 and spawn_link/1, we use Task.start/1 and Task.start_link/1
# which return {:ok, pid} rather than just the PID.
# This is what enables tasks to be used in supervision trees
# Furthermore, Task provides convenience functions, like
# Task.async/1 and Task.await/1, and functionality to ease distribution


# State
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end



{:ok, pid} = KV.start_link()

IO.puts "Created process"
send(pid, {:puts, "key", "value"})
send(pid, {:put, "key", "valuessss"})
send(pid, {:get, "key", self()})

receive do
  val -> IO.puts val
  _ -> IO.puts "Nothing"
end


# if the pid is not known, we can register it with a name
Process.register(pid, :kv)
send(:kv, {:put, "key", "new_value"})
IO.puts "Updated"
send(pid, {:get, "key", self()})

receive do
  val -> IO.puts val
  _ -> IO.puts "Nothing"
end

# The above KV module can be re-wrtitten as follows using Agent module
# {:ok, pid} = Agent.start_link(fn -> %{} end) -> To use PID
Agent.start_link(fn -> %{} end, [name: :kvz])
Agent.update(:kvz, fn map -> Map.put(map, "key", "nnnnew_value") end)
IO.puts "Updated"
IO.puts Agent.get(:kvz, fn map -> Map.get(map, "key") end)
