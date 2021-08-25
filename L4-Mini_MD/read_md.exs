parent = "/home/runner/AlchemistCampLessons"
folder = IO.gets("Enter the name of the folder you want to scan for image files ..>") |> String.trim()
dir = parent <> "/" <> folder

if File.dir?(Path.absname(dir)) do
  File.cd(Path.absname(dir))
  {_, files} = File.ls()
else
  IO.puts("#{folder} is not a valid folder\n")
end

case files do
  [] -> IO.puts "There are no files in the folder specified"
  _ -> {result, markdowns, location} = MiniMarkdown.scan4md(files, Path.absname(dir))
      IO.puts("Choose which file you want to convert to html: \n")
      for x <- 1..(length(markdowns) - 1), IO.puts("#{x + 1}. #{Enum.fetch!(markdowns, x)}")
      choice = IO.gets("Enter the corresponding file number: ") |> String.trim() |> String.to_integer()
end

md_choice = Enum.fetch!(markdowns, choice)
case File.read(md_choice) do
  {:ok, body} -> body
  {:error, reason} -> IO.puts(~s/Could not open the file #{filename}\n/)
                      IO.puts ~s("#{:file.format_error reason}"\n)
end

output = MiniMarkdown.to_html(body)
File.write("#{Regex.replace(~r/\.md/, md_choice, "")}.html",output)