defmodule ReactPhoenix do
  @moduledoc """
  Documentation for ReactPhoenix.
  """

  import Phoenix.HTML.Tag

  def react_component(name), do: react_component(name, %{})
  def react_component(name, props) when is_list(props) do
    react_component(name, Enum.into(props, %{}))
  end
  def react_component(name, props) when is_map(props) do
    props = Poison.encode!(props)
    content_tag(:div, "", [{:data, [react_class: name, react_props: props]}])
  end
  def react_component(name, props, opts) when is_map(props) do
    props = Poison.encode!(props)
    content_tag(:div, "", [{:data, [react_class: name, react_props: props, react_target_id: opts[:target_id]]}])
  end
end
