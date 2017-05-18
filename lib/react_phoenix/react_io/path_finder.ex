defmodule ReactPhoenix.ReactIo.PathFinder do
  @moduledoc false
  @app_dir File.cwd!
  @phoenix_1_3_react_stdio_path Path.join(~w(#{@app_dir} assets node_modules .bin react-stdio))
  @phoenix_1_2_react_stdio_path Path.join(~w(#{@app_dir} node_modules .bin react-stdio))
  @local_react_stdio_path Path.join(~w(node_modules .bin react-stdio))

  def react_stdio_path(), do: react_stdio_path(default_locations())
  def react_stdio_path(locations) when is_list(locations), do: do_react_stdio_path(locations)

  def do_react_stdio_path([]), do: raise("#{ReactPhoenix}: An installation of react-stdio cannot be found. Please run `npm install` and/or set the :react_stdio_path config value for :react_pheonix in your application.")
  def do_react_stdio_path([location | rest]) do
    case File.exists?(location) do
      true -> location
      false -> do_react_stdio_path(rest)
    end
  end

  defp default_locations do
    [@phoenix_1_3_react_stdio_path, @phoenix_1_2_react_stdio_path, @local_react_stdio_path]
  end
end
