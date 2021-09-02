defmodule AlchemyMdTest do
  use ExUnit.Case
  doctest AlchemyMd

  test "italicizes" do
    str = "Something *important*"
    assert AlchemyMd.to_html(str) =~ "<em>important</em>"
  end

  test "expands big tags" do
    str = "Some ++big++ words"
    assert AlchemyMd.big(str) =~ "<big>big</big>"
  end

  test "expands small tags" do
    str = "Some --small-- words"
    assert AlchemyMd.small(str) =~ "<small>small</small>"
  end

  test "expands hr tags" do
    str1 = "Stuff over the line\n---"
    str2 = "Stuff over the line\n***"
    str3 = "Stuff over the line\n- - -"
    str4 = "Stuff over the line\n*  *  *"
    str5 = "Stuff without line---"
    Enum.each([str1, str2, str3, str4], fn str ->
    assert AlchemyMd.hrs(str) =~ "Stuff over the line\n<hr />" 
    end)

    assert AlchemyMd.hrs(str5) =~ "Stuff without line---"
  end
end
