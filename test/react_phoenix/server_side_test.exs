defmodule ReactPhoenix.ServerSideTest do
  use ExUnit.Case
  doctest ReactPhoenix.ServerSide
  import ReactPhoenix.ServerSide

  test "react_component returns a string" do
    assert is_binary(react_component("hello"))
  end

  test "react_component returns an html string" do
    html = react_component("hello")
    assert html == "<h1 data-reactroot=\"\" data-reactid=\"1\" data-react-checksum=\"1174281205\"><!-- react-text: 2 -->Hello <!-- /react-text --></h1>"
  end

  test "react_component accepts props and the component utilizes them" do
    html = react_component("hello", %{name: "React"})
    assert html == "<h1 data-reactroot=\"\" data-reactid=\"1\" data-react-checksum=\"-1202902592\"><!-- react-text: 2 -->Hello <!-- /react-text --><!-- react-text: 3 -->React<!-- /react-text --></h1>"
  end
end
