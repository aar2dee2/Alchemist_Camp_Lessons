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

end