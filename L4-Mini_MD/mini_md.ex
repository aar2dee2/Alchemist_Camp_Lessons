defmodule MiniMarkdown do
  @moduledoc """
  A simple markdown parser
  """
  def to_html(text) do
    #lots of text transformations using a pipeline
    text 
      |> bold()
      |> italics()
      |> small()
      |> big()
      |> h3()
      |> h2()
      |> h1()
      |> p()
      |> breaks()
    #if the h1 function is called before h2, then '## ' also matches on the h1 regex. Hence, h2 is called first, and then h1.
  end
  
  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
  end

  def italics(text) do
    Regex.replace(~r/\*(.*)\*/, text, "<em>\\1</em>")
  end

  def p(text) do
    Regex.replace(~r/(\n|\r|\r\n|^)+([^\#\<][^\r\n]+)((\n|\r|\r\n)+$)?/, text, "<p>\\2</p>")
    #Modified the regex from the video after creating the h1 function, coz otherwise headings were also getting enclosing in p tags due to the existing newline characters. Creating an additional break function now to match against remaining newline characters.
    #this was the modified regex: ~r/(\n|\r|\r\n|^)+(?!\<h1\>)([^\r\n]+)((\n|\r|\r\n)+$)?/
    #the above is very specific to avoiding h1 tags only, however there may be other html tags, such as <div> that are included in the markdown directly. So we modify the regex to not capture anything starting with '#' and '<'.
  end

  def h1(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)\# +([^#][^\n|\r|\r\n]+)([\n|\r|\r\n])/, text, "<h1>\\2</h1>\\3")
    #Regex used in video was: 
    #since the heading must start on a new line or be at the beginning of the document we need to match for beginning of document or new line before capturing the '#'
    #notice the '+' after the space '\# +' - A hash may be followed by any number of spaces for it be a heading. The extra spaces are just part of the heading. So we need to match on exactly one '#' sign and one or more spaces.
    #breakdown of the regex used: ~r/(\#{1} )([^\n|\r|\r\n]+)([\n|\r|\r\n])/
    #first part is '# ', since # is a special character, it is escaped using a backslash '\'.
    #We're looking for one occurrence of '# ', which means 'we don't want '# # heading' to become 'heading', but '# heading'. So to get exactly one occurrence of a group we use {1}.
    #Now the '# ' can be followed by anything other than a new line so we create a group for anything other than newline by using the caret sign '^' before the newline symbol. We put this part in round brackets, because we want this part to be remembered - it will be used in our final output. so we get ([^\r\n]+) - we use the '+' sign to indicate one or more occurrences
    #Finally a heading must at a newline character, so we use the group of newline character options [\n|\r|\r\n] and we want this group to be remembered because we will have to add corresponding newline in our final output so we put it in round brackets and this becomes are second capture.
    #so when writing the output text, we want the first capture between the h1 tags and the second capture after the closing h1 tag. So we have "<h1>\\1</h1>>\\2"
  end

  
  def h2(text) do
    Regex.replace(~r/(\#{2} )([^\n|\r|\r\n]+)([\n|\r|\r\n])/, text, "<h2>\\2</h2>\\3")
  end
  
  def h3(text) do
    Regex.replace(~r/(\#{3} )([^\n|\r|\r\n]+)([\n|\r|\r\n])/, text, "<h3>\\2</h3>\\3")
  end

  def big(text) do
    Regex.replace(~r/(%{2})([^%{2}]+)(%{2})/, text, "<big>\\2</big>")
  end

  def breaks(text) do
    Regex.replace(~r/(\n|\r\n|\r)/, text, "<br>")
  end

  def small(text) do
    Regex.replace(~r/(%{4})([^%{4}]+)(%{4})/, text, "<small>\\2</small>")
  end

  def test_string do
    """
    I *so* enjoyed eating that burrito and the hot sauce was **amazing**
        
    ### So many headings
    so less text %%%%this is going to be smaller%%%% than this text which is %%going to be huge%%


    # This is a heading

    ## this is a subheading

    what did you think of it?



    """
  end

  def scan4md([], dir) do
    IO.puts "There are no files in the #{dir} folder"
  end

  def scan4md(files, dir) do
    mds = Enum.filter(files, &Regex.match?(~r{(\.md)}, &1))
    case mds do
      [] -> {:no_markdown_files, [], dir}
      _ -> {:ok, mds, dir}
    end
  end

end