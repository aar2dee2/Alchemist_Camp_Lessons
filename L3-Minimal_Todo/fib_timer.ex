defmodule FibTimer do
  @moduledoc """
  Contains functions to generate fibonacci sequence with n numbers and calculate the time required for the function to be performed
  """

  def start() do
    {:ok, start_time} = DateTime.now("Etc/UTC")
    IO.inspect(fibonacci())
    {:ok, end_time} = DateTime.now("Etc/UTC")
    fib_time = DateTime.diff(end_time, start_time, :nanosecond)
    IO.puts "The time taken by the fibonacci function to return a list of 45 numbers is #{fib_time} nanoeconds."
  end


  @doc since: "1.12.1"
  @doc """
  A function to generate a fibonacci sequence of `n` numbers, where `n` is input by the user and the default value of `n` is 45.
  """
  @spec fibonacci(number()) :: [number()]
  def fibonacci(n \\ 45) when n > 0 do
    fibonacci(Enum.reverse([1, 1, 2]), 3, n)
  end

  def faster(1, 0, 
  
  def faster(n, acc1, acc2) do
    faster(n-1, acc2, acc1 + acc2)
  end
  #below iss the older approach
  def fibonacci(list, counter, n) when counter < n do
    cond do
      n <= 3 -> Enum.take(Enum.reverse(list), n)
      true -> new = Enum.take(list, 2) |> Enum.sum()
              fibonacci([new | list], counter + 1, n)
    end
  end

  def fibonacci(list, _counter, _n) do
    Enum.reverse(list)
  end
end