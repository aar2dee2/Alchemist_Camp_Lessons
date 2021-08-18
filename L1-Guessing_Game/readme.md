## Alchemist Camp Lesson 1 - Guessing Game

The [Alchemist Camp](https://alchemist.camp/) website has lots of free tutorials for Elixir beginners. Each tutorial is a guided video lesson on Youtube and the source code is available on Github.

In this repl, I'm trying out the first lesson [Alchemist Camp Lesson 1 - Guessing Game](https://alchemist.camp/episodes/guessing-game)

The guessing game is a simple game wherein the program tries to 'guess' a number chosen by the user. The user can pick a number lying in a defined range of numbers.

The program then begins guessing the user's choice by generating a random number in the specified range. 
- If the number output by the program is the user's choice, the user enters "yes" and the program is terminated. 
- If the the user's choice is bigger than the number output by the program, the user inputs "bigger" and the program chooses a random number again using the revised range. 
- Conversely, if the user's choice is smaller than the number output by the program, the user inputs 'smaller' and the program is generates a random number again which will be smaller than the previous output. The program continues to generate random numbers, until the user's choice is output by the program.