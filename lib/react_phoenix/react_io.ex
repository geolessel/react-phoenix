defmodule ReactPhoenix.ReactIo do
  use StdJsonIo, otp_app: :react_phoenix, script: "node_modules/.bin/react-stdio"
end
