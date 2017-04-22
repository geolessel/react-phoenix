use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

config :porcelain, driver: Porcelain.Driver.Basic

config :react_phoenix, compiled_path: Path.join(["priv", "static", "js", "components"])

import_config "#{Mix.env}.exs"
