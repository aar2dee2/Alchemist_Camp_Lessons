filename = IO.gets("Enter the name of the file (including parent folder) to count the words from: ") |> String.trim()

choice = IO.gets("Pick what you want to count:
1. (L)ines
2. (W)ords
3. (C)haracters >") |> String.trim() |> String.first()

num = FileCount.count(filename, choice)

#words = File.read!(Path.relative(filename)) |> String.split(~r{(\\n|[^\w'])+}) |> Enum.filter(fn x -> x != "" end)

#using Path.relative(path) since the file path given will be in the parent directory of the current directory. So it is relative to the current directory.

#breakdown of the regex:
#To match word characters we use: \w
#But we want to match on everything except word characters so we a caret (^) before it and then put it inside square brackets (we want the caret and \w to be treated as a group): [^\w]
#Since we also don't want to match on '\n' we add that as an option using the pipe operator so put the regex inside round brackets and then put a pipe between \n and [^\w]. The \ in \n needs to be escaped. So we use \\n: (\\n|[^\w'])+ 
#We use the + sign since there can be more than one \n and word characters.
#Finally the apostrophe are also word characters so they're will get split into "they" and "re", which we don't want. So inside the square bracket with \w, we also added the apostrophe (') so that that is also not matched on: (\\n|[^\w']+)
#IO.inspect(words)
type = cond do
        choice in ["1", "l", "L"] -> "Lines"
        choice in ["2", "w", "W"] -> "Words"
        choice in ["3", "c", "C"] -> "Characters"
        true -> nil
      end
IO.puts("There are #{num} #{type} in the file #{filename}")