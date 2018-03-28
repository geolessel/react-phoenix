defmodule ReactPhoenix.ClientSideTest do
  use ExUnit.Case
  doctest ReactPhoenix.ClientSide
  import ReactPhoenix.ClientSide

  test "react_component/1 returns a safe tuple" do
    assert {:safe, _} = react_component("test")
  end

  test "react_component/1 returns a renderable div" do
    html = Phoenix.HTML.safe_to_string(react_component("test"))
    assert String.match?(html, ~r|^<div.*></div>$|)
  end

  test "react_component/1 returns a renderable div with data-react-class containing component name" do
    html = Phoenix.HTML.safe_to_string(react_component("test"))
    assert String.match?(html, ~r|data-react-class="test"|)
  end

  test "react_component/2 returns a renderable div with data-react-props containing props list" do
    html = Phoenix.HTML.safe_to_string(react_component("test", my: "props"))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component/2 returns a renderable div with data-react-props containing props map" do
    html = Phoenix.HTML.safe_to_string(react_component("test", %{my: "props"}))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component/3 accepts a target div option" do
    html = Phoenix.HTML.safe_to_string(react_component("test", %{}, target_id: "test-id"))

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"test-id\"></div>"

    assert html == expected
  end

  test "react_component/3 accepts a html_element option" do
    html = Phoenix.HTML.safe_to_string(react_component("test", %{}, html_element: :span))

    expected =
      "<span data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"\"></span>"

    assert html == expected
  end

  test "react_component/3 passes on extra options to the html element" do
    html = Phoenix.HTML.safe_to_string(react_component("test", %{}, class: "row", id: "content"))

    expected =
      "<div class=\"row\" data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"\" id=\"content\"></div>"

    assert html == expected
  end
end
