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
end
