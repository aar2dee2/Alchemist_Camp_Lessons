defmodule WordCount do
  @moduledoc """
  Documentation for `WordCount`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WordCount.hello()
      :world

  """
  def start(parsed, file, invalid) do
    if (invalid != []) or (file == "h") do
       show_help()
    else
       read_file(parsed, file)
    end
  end

  def show_help() do
     IO.puts """
     Usage: [filename] -[flags]
     Flags
     -l displays line count
     -c displays character count
     -w displays word count (default)

     Multiple flags may be used. Example usage to display line and character count:

     somefile.txt -lc
     
     """
  end

  def read_file(parsed, file) do
    flags = case Enum.count(parsed) do
      0 -> [:words]
      _ -> Enum.map parsed, &(elem(&1, 0))
    end

    IO.inspect flags
  end

  
end
