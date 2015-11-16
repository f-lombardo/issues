defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI

  test ":help returned by -h and --help" do
    assert parse_args(["--help", "blabla", "piropiro"]) == :help
    assert parse_args(["-h", "blabla", "piropiro"]) == :help
  end

  test "3 values returned for 3 values provided" do
    assert parse_args(["a", "b", "99"]) == {"a", "b", 99}
  end

  test "3 values returned for 2 values provided: last parameter is default count" do
    assert parse_args(["a", "b"]) == {"a", "b", default_count()}
  end

  test "sorting in the right order" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end 

  defp fake_created_at_list(values) do
    data = for value <- values, 
           do: [{"created_at", value}, {"other_data", "xyz"}]
    convert_to_list_of_hashdicts data
  end
end
