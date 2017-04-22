defmodule ReactPhoenix do
  @moduledoc false

  def react_component(name, props \\ %{}), do: ReactPhoenix.ClientSide.react_component(name, props)
  def react_component(name, props, opts), do: ReactPhoenix.ClientSide.react_component(name, props, opts)
end
