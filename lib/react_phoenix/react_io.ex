defmodule ReactPhoenix.ReactIo do
  @moduledoc false

  use StdJsonIo, otp_app: :react_phoenix, script: "node_modules/.bin/react-stdio"
end
