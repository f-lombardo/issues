defmodule Issues.ConsoleFormat do
  def puts(list_of_issues) do
    columns = [{"number", 10}, {"created_at", 25}, {"title", 54}]
    
    printing_function = &IO.write/1

    separator columns, printing_function
    header_string columns, printing_function
    separator columns, printing_function
    body_string list_of_issues, columns, printing_function
    separator columns, printing_function
  end

  def separator([], printing_function) do
    printing_function.("-\n")
  end
  def separator([{_, size} | tail], printing_function) do
    printing_function.(String.ljust("", size, ?-))
    separator(tail, printing_function)
  end

  def header_string([], printing_function) do
    printing_function.("|\n")
  end
  def header_string([{title, size} | tail], printing_function) do
    printing_function.(String.ljust("|#{title}", size))
    header_string(tail, printing_function)
  end

  def body_string([], _, _printing_function) do
    #Nothing
  end
  def body_string([first_issue | other_issues], columns, printing_function) do
    row(first_issue, columns, printing_function)
    body_string(other_issues, columns, printing_function)
  end

  def row(_, [], printing_function) do
    printing_function.("|\n")
  end
  def row(issue, [{title, size} | tail], printing_function) do
    value = issue[title]
    printing_function.(String.ljust("|#{value}", size))
    row(issue, tail, printing_function)
  end
end