defmodule ReactPhoenix do
  @moduledoc """
  Functions for rendering of React.js components.
  """

  @doc """
  (Depricated) provides functions for client-side rendering of React.js components

  As of v0.4.0, please use `ElixirCabinet.ClientSide.react_component/2` instead. Provided for backward
  compatability for versions < 0.4.0.
  """
  def react_component(name, props \\ %{}), do: ReactPhoenix.ClientSide.react_component(name, props)

  @doc """
  (Depricated) provides functions for client-side rendering of React.js components

  As of v0.4.0, please use `ElixirCabinet.ClientSide.react_component/3` instead. Provided for backward
  compatability for versions < 0.4.0.
  """
  def react_component(name, props, opts), do: ReactPhoenix.ClientSide.react_component(name, props, opts)
end
