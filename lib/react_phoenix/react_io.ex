defmodule ReactPhoenix.ReactIo do
  @moduledoc false
  use StdJsonIo, otp_app: :react_phoenix,
    script: fn ->
      react_stdio_path = (Application.get_env(:react_phoenix, :react_stdio_path) || ReactPhoenix.ReactIo.PathFinder.react_stdio_path())
      case Application.get_env(:react_phoenix, :node_modules_path) do
        nil ->
          react_stdio_path
        node_modules_path ->
          Enum.join([
            "NODE_PATH=",
            node_modules_path,
            " ",
            react_stdio_path
          ])
      end
    end.()
end
