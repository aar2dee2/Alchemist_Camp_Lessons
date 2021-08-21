defmodule MinimalTodo do

  @moduledoc """
  The `MinimalTodo` module allows the user to read/update/modify a Todo List inside a csv file. The following options are available:
    - read todos
    - add todos
    - delete todos
    - load file
    - save file
  """

  @doc """
  """
  @doc since: "1.12.1"
  def start() do
    filename = IO.gets("Enter the name of the csv to read: ") |> String.trim()
    read(filename)
      |> parse()
      |> get_command()
  end

  def get_command(data) do
    prompt = IO.gets("""
                      Type the first letter of the command you want to run:
                      (R)ead Todos
                      (A)dd a Todo
                      (D)elete a Todo
                      (L)oad a .csv
                      (S)ave a .csv 
                      (Q)uit
                      """)
            |> String.trim()
            |> String.downcase()
            |> String.first()
    case prompt do
      "r" -> show_todos(data)
      "d" -> delete_todos(data)
      "q" -> "Goodbye!"
      _ -> IO.puts "That is not an acceptable command."
            get_command(data)
    end
    
  end

  def delete_todos(data) do
    todo = IO.gets("Which Todo would you like to delete?\n") |> String.trim()
    if Map.has_key? data, todo do
      IO.puts "ok"
      new_data = Map.drop(data, [todo])
      IO.puts("the Todo #{todo} has been deleted\n")
      get_command(new_data)
    else
      IO.puts("There is no Todo named #{todo}!\n")
      show_todos(data, false)
      delete_todos(data)
    end
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} -> body
      {:error, reason} -> IO.puts(~s/Could not open the file #{filename}\n/)
      IO.puts ~s("#{:file.format_error reason}"\n)
      start()
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\n|\r)}) |> Enum.filter(fn x -> x != "" end)
    titles = tl(String.split(header, ",") |> Enum.filter(fn x -> x != "" end))
    parse_lines(lines, titles)

  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built -> 
      [name | fields] = (String.split(line, ",") |> Enum.filter(fn x -> x != "" end))
      if Enum.count(fields) == Enum.count(titles) do
        line_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def show_todos(data, next_command? \\ true) do
    items = Map.keys data
    IO.puts "You have the following todos: \n"
    Enum.each items, fn item -> IO.puts item end
    IO.puts "\n"
    if next_command? do
      get_command(data)

    #else
    end
  end

end