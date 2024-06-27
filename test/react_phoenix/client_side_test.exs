defmodule ReactPhoenix.ClientSideTest do
  use ExUnit.Case
  doctest ReactPhoenix.ClientSide
  import ReactPhoenix.ClientSide
  import Phoenix.LiveViewTest

  test "react_component/1 returns a safe tuple" do
    assert {:safe, _} = react_component("test")
  end

  test "react_component/1 returns a renderable div" do
    html =
      "test"
      |> react_component()
      |> rendered_to_string()

    assert String.match?(html, ~r|^<div.*></div>$|)
  end

  test "react_component/1 returns a renderable div with data-react-class containing component name" do
    html =
      "test"
      |> react_component()
      |> rendered_to_string()

    assert String.match?(html, ~r|data-react-class="test"|)
  end

  test "react_component/2 returns a renderable div with data-react-props containing props list" do
    html =
      "test"
      |> react_component(my: "props")
      |> rendered_to_string()

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component/2 returns a renderable div with data-react-props containing props map" do
    html =
      "test"
      |> react_component(%{my: "props"})
      |> rendered_to_string()

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{&quot;my&quot;:&quot;props&quot;}\"></div>"

    assert html == expected
  end

  test "react_component/3 accepts a target div option" do
    html =
      "test"
      |> react_component(%{}, target_id: "test-id")
      |> rendered_to_string()

    expected =
      "<div data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"test-id\"></div>"

    assert html == expected
  end

  test "react_component/3 accepts a html_element option" do
    html =
      "test"
      |> react_component(%{}, html_element: :span)
      |> rendered_to_string()

    expected =
      "<span data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"\"></span>"

    assert html == expected
  end

  test "react_component/3 passes on extra options to the html element" do
    html =
      "test"
      |> react_component(%{}, class: "row", id: "content")
      |> rendered_to_string()

    expected =
      "<div id=\"content\" class=\"row\" data-react-class=\"test\" data-react-props=\"{}\" data-react-target-id=\"\"></div>"

    assert html == expected
  end
end
