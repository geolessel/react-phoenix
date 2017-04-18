defmodule ReactPhoenix do
  @moduledoc """
  Documentation for ReactPhoenix.
  """

  import Phoenix.HTML.Tag

  def react_component(name, props \\ %{}) do
    props = Poison.encode!(props)
    content_tag(:div, "", [{:data, [react_class: name, react_props: props]}])
  end
end
