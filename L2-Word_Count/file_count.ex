defmodule FileCount do
  @moduledoc """
  Counts the number of words OR characters OR lines in a given file depending on the user's choice.
  """

  @doc """
  """

  @doc since: "1.12.1"
  @spec count(String.t(), String.t()) :: integer()
  def count(filename, choice) 
    when choice in ["1", "l", "L"] do
    body = File.read!(Path.relative(filename))
    #Tried the following regex to get lines:
    # ~r{[\\n]+}
    # ~r{[\(\n)]+}
    # ~r{\\n}
    String.split(body, ~r{(\r\n|\n|\r)})
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.count()
  end

  def count(filename, choice)
    when choice in ["2", "w", "W"] do
    body = File.read!(Path.relative(filename))
    String.split(body, ~r{(\\n|[^\w'])+})
      |>Enum.filter(fn x -> x != "" end)
      |> Enum.count()
  end

  def count(filename, choice)
    when choice in ["3", "c", "C"] do
    body = File.read!(Path.relative(filename))
    #Initially split into words, then chars, however there can be chars outside words also.
    #words = String.split(body, ~r{(\\n|[^\w'])+}) |>Enum.filter(fn x -> x != "" end)
    #chars = (for x <- words, do: String.graphemes(x)) |> List.flatten()
    chars = String.split(body, "") |> Enum.filter(fn x -> x != "" end)
    Enum.count(chars)
  end

  def count(filename, _choice) do
    new_choice = IO.gets("Make one of the following choices:
                          1. (L)ines
                          2. (W)ords
                          3. (C)haracters >")
                  |> String.trim()
                  |> String.first()
    count(filename, new_choice)
  end

  
end