defmodule AlchemyMd do
  @moduledoc """
  Documentation for `AlchemyMd`.
  """

  @doc """
  Converts markdown text to formatted html text by using the Earmark package. https://github.com/pragdave/earmark
  """
  @doc since: "1.12.2"

  def to_html(markdown) do
    Earmark.as_html!((markdown || ""), %Earmark.Options{smartypants: false})
  end

  def big(s) do
    Regex.replace(~r/\+\+(.*)\+\+/, s, "<big>\\1</big>")
  end

  def small(s) do
    Regex.replace(~r/\-\-(.*)\-\/, s, "<small>\\1</small>")
  end
end