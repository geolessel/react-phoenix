defmodule ReactPhoenix.ReactIo do
  @moduledoc false

  use StdJsonIo, otp_app: :react_phoenix, script: Application.get_env(:react_phoenix, :react_stdio_path, ReactPhoenix.ReactIo.PathFinder.react_stdio_path())
end
