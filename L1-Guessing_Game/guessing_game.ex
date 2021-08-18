defmodule GuessingGame do
  @moduledoc """
  A module encoding a simple game wherein the program tries to 'guess' a number chosen by the user. The user can pick a number lying in a defined range of numbers. The program then begins guessing the user's choice by generating a random number in the specified range. 
  - If the number output by the program is the user's choice, the user enters "yes" and the program is terminated. 
  - If the the user's choice is bigger than the number output by the program, the user inputs "bigger" and the program chooses a random number again using the revised range. 
  - Conversely, if the user's choice is smaller than the number output by the program, the user inputs 'smaller' and the program is generates a random number again which will be smaller than the previous output. The program continues to generate random numbers, until the user's choice is output by the program.
  """

  @doc """
  """

  @doc since: "Erlang/OTP 24 Elixir 1.12.1"

  @spec generate(integer(), integer()) :: integer() | String.t()
  def generate(a, b) do
    num = div(a + b, 2)
    low = min(a, b)
    high = max(a, b)
    IO.puts("#{num}")
    ans = IO.gets(~s{Is this the number chosen by you?
    1. Yes
    2. No, my number is bigger
    3. No, my number is smaller
    >}) |> String.trim() |> String.first() |> String.to_integer()
    case ans do
      1 -> IO.puts("Your choice was #{num}. Game over.") 
      2 -> IO.puts("Let's guess again")
            generate(min(high, num+1), high)
            #using min(high, num+1) because when you say the number is higher than the guess, you don't want to see the guess again (which is num) but start from the number after it. But this should not take it higher than the 
      3 -> IO.puts("Let's guess again")
            generate(low, max(low, num-1))
    end
  end

end