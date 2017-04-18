defmodule Mix.Tasks.ReactPhoenix.Install do
  @moduledoc """
  Install the javascript file(s) necessary for ReactPhoenix to run properly
  """
  use Mix.Task

  def run(_args) do
    info "\nInstalling ReactPhoenix..."
    info "Copying javascript files..."
    case File.cp("./_build/dev/lib/react_phoenix/priv/js/react_phoenix.js", "./web/static/js/react_phoenix.js") do
      :ok ->
        info "Done."
        info "Adding required import to web/static/js/app.js..."
        cmd "echo '\nimport reactPhoenix from \"./react_phoenix\"' >> ./web/static/js/app.js"
        cmd "echo 'reactPhoenix()\n' >> ./web/static/js/app.js"
        info "Done."
      {:error, reason} -> error "Could not copy files: #{reason}"
    end
    info "\nIf you want the react_component function available in your view files,"
    info "make sure to add `import ReactPhoenix` in the `view` section"
    info "of your web/web.ex file."
  end

  defp info(txt), do: Mix.shell.info(txt)
  defp error(txt), do: Mix.shell.error(txt)
  defp cmd(txt), do: Mix.shell.cmd(txt)
end
