# Issues

**Exercise from "Programming Elixir"**

Little project to show issues from github project

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add issues to your list of dependencies in `mix.exs`:

        def deps do
          [{:issues, "~> 0.0.1"}]
        end

  2. Ensure issues is started before your application:

        def application do
          [applications: [:issues]]
        end

## Running

    mix escript.build

On Unix

    ./issues

On Windows

    escript .\issues

Another way of running the program

    mix issues <user> <project> [count]
