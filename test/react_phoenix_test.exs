defmodule ReactPhoenixTest do
  use ExUnit.Case
  doctest ReactPhoenix
  import ReactPhoenix.ClientSide
  import Phoenix.LiveViewTest

  test "react_component returns a renderable div" do
    html = rendered_to_string(react_component("test"))
    assert String.match?(html, ~r|^<div.*></div>$|)
  end

  test "react_component returns a renderable div with data-react-class containing component name" do
    html = rendered_to_string(react_component("test"))
    assert String.match?(html, ~r|data-react-class="test"|)
  end

  test "react_component returns a renderable div with data-react-props containing props list" do
    html = rendered_to_string(react_component("test", my: "props"))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component returns a renderable div with data-react-props containing props map" do
    html = rendered_to_string(react_component("test", %{my: "props"}))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component accepts a target div option" do
    html = rendered_to_string(react_component("test", %{}, target_id: "test-id"))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"test-id\"></div>"

    assert html == expected
  end
end
