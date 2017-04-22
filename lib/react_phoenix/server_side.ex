defmodule ReactPhoenix.ServerSide do
  @path_prefix Application.get_env(:react_phoenix, :compiled_path)

  def react_component(component, props \\ %{}) do
    ReactPhoenix.ReactIo.json_call!(%{
      component: Path.join(@path_prefix, "#{component}.js"),
      props: props
    })
  end
end
