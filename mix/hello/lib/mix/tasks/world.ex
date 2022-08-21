defmodule Mix.Tasks.World do
  @moduledoc """
    This world mix task: `mix help world`
  """
  use Mix.Task

  @shortdoc "Simply calls the Hello.say/0 function."
  def run(_) do
    # This will start our application
    Mix.Task.run("app.start")

    # calling our Hello.say() function from earlier
    Hello.say()
  end
end
