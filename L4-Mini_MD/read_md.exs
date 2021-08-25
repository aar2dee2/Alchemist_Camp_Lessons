parent = "/home/runner/AlchemistCampLessons"
folder = IO.gets("Enter the name of the folder you want to scan for image files ..>") |> String.trim()
dir = parent <> "/" <> folder

{outcome, files} = if File.dir?(Path.absname(dir)) do
  File.cd(Path.absname(dir))
  File.ls()
else
  {:invalid_folder, []}
end

{result, markdowns, location} = case files do
  [] -> IO.puts "There are no files in the folder specified"
        {:no_files, [], dir}
  _ -> MiniMarkdown.scan4md(files, Path.absname(dir))
end

if markdowns != [] do
  IO.puts("Choose which file you want to convert to html: \n")
  for x <- 0..(length(markdowns) - 1), do: IO.puts("#{x + 1}. #{Enum.fetch!(markdowns, x)}\n")
  choice = IO.gets("Enter the corresponding file number: ") |> String.trim() |> String.to_integer()

  md_choice = Enum.fetch!(markdowns, choice - 1)
  body = case File.read(md_choice) do
          {:ok, body} -> body
          {:error, reason} -> ""
         end
  output = MiniMarkdown.to_html(body)
  File.write("#{Regex.replace(~r/\.md/, md_choice, "")}.html",output)
else
  IO.puts "There are no markdown files in the selecrteed folder"
end