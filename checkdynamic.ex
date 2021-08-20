defmodule Dynamic do

  @spec fun(String.t(), integer()) :: integer()
  def fun(str, num) do
    str + num
  end

  def weirdsum() do
    "3" + 5
  end
end