defmodule Example do
  def add(a, b) do
    IO.puts(a + b)
  end

  def listen do
    receive do
      {:ok, val} -> IO.puts(val)
    end

    listen()
  end
end

pid = spawn(Example, :add, [3, 4])
IO.inspect pid

pid = spawn(Example, :listen, [])
send pid, {:ok, "hello"}
send pid, {:ok, "hello1"}
send pid, {:ok, "hello2"}
send pid, {:ok, "hello3"}
IO.puts "done"

defmodule ExampleError do
  def explode, do: exit(:kaboom)

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(ExampleError, :explode, [])

    receive do
      {:EXIT, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end
end

ExampleError.run()

defmodule ExampleMonitoring do
  def explode, do: exit(:kaboom)

  def run do
    spawn_monitor(ExampleMonitoring, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end
end


{:ok, agent} = Agent.start_link(fn -> [1, 2, 3] end)
Agent.update(agent, fn (state) -> state ++ [4, 5] end)
IO.inspect Agent.get(agent, &(&1))

Agent.start_link(fn -> [1, 2, 3] end, name: Numbers)
IO.inspect Agent.get(Numbers, &(&1))

defmodule ExampleTask do
  def double(x) do
    :timer.sleep(2000)
    x * 2
  end
end

task = Task.async(ExampleTask, :double, [2000])
IO.puts "done one"
:timer.sleep(2000)
IO.puts "done two"
IO.puts Task.await(task)
IO.puts "done three"
