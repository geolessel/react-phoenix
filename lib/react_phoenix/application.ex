defmodule ReactPhoenix.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ReactPhoenix.ReactIo, [])
    ]

    opts = [strategy: :one_for_one, name: ReactPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
