defmodule CliApp do
  @moduledoc """
  Documentation for `CliApp`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CliApp.hello()
      :world

  """
  def hello do
    :world
  end
end


defmodule CliApp.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> response
    |> IO.puts
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean])

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    if opts[:upcase], do: String.upcase(word), else: word
  end
end
