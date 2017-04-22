defmodule ReactPhoenix.Server do
  @path_prefix Path.join(["priv", "static", "js", "components"])

  def react_component(component, props \\ %{}) do
    ReactPhoenix.ReactIo.json_call!(%{
      component: Path.join(@path_prefix, "#{component}.js"),
      props: props
    })
  end
end
