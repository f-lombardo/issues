defmodule Mix.Tasks.Issues do
  use Mix.Task

  def run(args) do
    Issues.CLI.main(args)
  end
end