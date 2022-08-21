defmodule CliAppTest do
  use ExUnit.Case
  doctest CliApp

  test "greets the world" do
    assert CliApp.hello() == :world
  end
end
