defmodule MoveImages do
  @moduledoc """
  The `MoveImages` module allows the user to scan all the files in a given directory and move the image files (.jpg, jpeg, .png, .gif, .tif) to a separate folder within the directory. 
  """

  @doc """
  The `MoveImages.read_dir/0` function asks the user to input the name of a directory that will be scanned for the presence of image files. The image files found will be returned as a list, if no images are found, an empty list is returned.
  """
  @doc since: "1.12.1"
  @spec read_dir() :: list() | String.t() 
  def read_dir() do
    parent = "/home/runner/AlchemistCampLessons"
    File.cd!(parent)
    folder = IO.gets("Enter the name of the folder you want to scan for image files ..>") |> String.trim()
    dir = parent <> "/" <> folder
    if File.dir?(Path.absname(dir)) do
      File.cd(Path.absname(dir))
      {_, files} = File.ls()
      scan4img(files, Path.absname(dir))
    else
      IO.puts("#{folder} is not a valid folder\n")
      read_dir()
    end 
  end

  @doc """
  The `MoveImages.scan4img/2` function accepts a list of files and their source folder as inputs and returns a list of image files present in the source folder. If there are no image files, it prints "There are no image files in the folder specified" to the console.
  """

  @spec scan4img(list(), String.t()) :: String.t() | list()
  def scan4img([], dir) do
    IO.puts "There are no files in the #{dir} folder"
  end

  def scan4img(files, dir) do
    images = Enum.filter(files, &Regex.match?(~r{(\.jpg|\.jpeg|\.png|\.gif|\.tif)}, &1))
    case images do
      [] -> IO.puts "There are no images in the #{dir} folder."
      _ -> IO.puts "The folder contains the following image files: \n"
          for img <- images, do: IO.puts("#{img}")
          destination = IO.gets("Enter the name of the folder to which images should be moved: \n") |> String.trim()
          move_images(destination, images, files, dir)
    end
  end

  @doc """
  The `MoveImages.move_images/3` function accepts the name of a destination folder, a list of image files, and the list of all files/folders in the parent folder as inputs. It checks for the existence of the destination folder in the parent folder. If the folder is present, it move the image files to this folder. Else, it creates the destination folder and moves the image files to this folder.
  """
  def move_images(destination, images, files, dir) do
    if Enum.member?(files, destination) do
      des_files = File.ls(destination) |> elem(1)
      for img <- images, 
        !Enum.member?(des_files, img),
        do: File.cp(dir <> "/" <> img, dir <> "/" <> destination <> "/" <> img)
      {_, parent_files} = File.ls(Path.absname(dir))
      for img <- images, 
        Enum.member?(parent_files, img),
        do: File.rm(dir <> "/" <> img)
    else
      File.mkdir(destination)
      for img <- images,
        do: File.cp(dir <> "/" <> img, dir <> "/" <> destination <> "/" <> img)
      {_, parent_files} = File.ls(Path.absname(dir))
      for img <- images, 
        Enum.member?(parent_files, img),
        do: File.rm(dir <> "/" <> img)
    end
  end
end