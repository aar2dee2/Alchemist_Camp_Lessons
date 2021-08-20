defmodule GreetUser do
  @moduledoc """
  Ask the user for their name and greet them. If the user enters the name of the programmer, output a different expression.
  """

  @doc """
  Accept the name of the user as input and greet the user. If the user inputs the name of the programmer, output a different greeting.
  """
  @doc since: "Erlang/OTP 24 Elixir 1.12.1"
  @spec greet(String.t()) :: String.t()
  def greet(name) do
    formatted_name = String.trim(name) |> String.downcase()
    case formatted_name do
      "sam" -> IO.puts("Wow!, #{name} is my favorite name in the world. I was created by #{formatted_name}")
      _ -> IO.puts("Hey there, #{name}!")
    end
  end
end