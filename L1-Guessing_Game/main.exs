name = IO.gets("Enter your name >") |> String.trim()

GreetUser.greet(name)

IO.puts("Let's play a guessing game.\nPick a positive integer and we will guess it for you. You will need to give us the beginning and end of the range which contains the number chosen by you.\n")

num1 = IO.gets("Enter the number at the beginning of the range >") |> String.trim() |> String.to_integer()

num2 = IO.gets("Enter the number at the end of the range >") |> String.trim() |> String.to_integer()

GuessingGame.generate(num1, num2)