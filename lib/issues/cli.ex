defmodule Issues.CLI do
  def default_count, do: 4

  def main(argv) do
    argv
      |> parse_args
      |> process
  end


  def process(:help) do
    IO.puts """
    Usage: issues <user> <project> [count]
    """
  end
  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_hashdicts
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> Issues.ConsoleFormat.puts
  end

  def sort_into_ascending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
  end

  def decode_response({:ok, body}) do
    body
  end
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from GitHub: #{message}"
    System.halt(2)
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help ])
    case parse do
      {[help: true], _, _}
        -> :help

      { _, [user, project, count], _}
        -> {user, project, String.to_integer(count)}

      { _, [user, project], _}
        -> {user, project, default_count()}
      _
        -> :help
    end
  end

  def convert_to_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end
end
