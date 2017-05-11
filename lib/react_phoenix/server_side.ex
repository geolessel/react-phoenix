defmodule ReactPhoenix.ServerSide do
  @moduledoc """
  Functions providing server-side rendering of React components.

  ## What? Why?

  Server-side rendering of React components can be important for things
  such as Search Engine Optimization. In short, we have our Phoenix
  controller gather the HTML that would be generated by a React component
  (including utilizing any props required) and pass that directly into the
  view template. Once there, we can render the string directly on initial
  page load so that loading is fast and data is there when a search engine
  crawler finds the page.

  ## Configuration

  In order to get this working correctly, you need to take a few extra
  steps beyond the setup for client-side rendering. Add `:react_phoenix`
  to your `applications` list.

  ### `mix.exs`

  ```
  def application do
    [mod: {YourApp, []},
     applications: [..., :react_phoenix]
    ]
  end
  ```

  We eventually will need to compile your React components down into
  commonjs files so our renderer can understand it. Choose a directory for
  those compiled components to live in (and remember it because you'll need
  it in a few different spots) and let ReactPhoenix know about it. You do
  that in your `config/config.exs` file:

  ### `config/config.exs`

  ```
  config :react_phoenix,
    compiled_path: Path.join(["priv", "static", "js", "components"])
  ```

  This tells our renderer to look for the component in the
  `priv/static/js/components` directory.

  Configure your Endpoint to watch for new component files and compile them
  down as it finds them (but only in dev). If you have a standard Phoenix
  setup, you likely already have at least one watcher set up for your
  Endpoint. *Be careful not to overwrite* anything you currently have
  configured, but to add a new watcher.


  Additionally, you may need to specify the route of your react-stdio module
  if your node_modules directory does not live in the root directory of your
  project. *(E.g. Your ReactPhoenix project lives within an umbrella project.)*

  Do this in your `config/config.exs` file.

  ```
  config :react_phoenix,
    ...
    react_stdio_path: Path.join(["path_to_your_app","node_modules", ".bin", "react-stdio"])
  ```

  If the aforementioned does not apply, you can ignore this step and use the default path.


  ### `config/dev.exs`

  ```
  config :your_app, YourApp.Endpoint,
    watchers: [
      node: [                                  # This is likely already there
        "node_modules/brunch/bin/brunch", "watch", "--stdin",
        cd: Path.expand("../", __DIR__)
      ],
      node: [                                  # We need to add this new one
        "node_modules/babel-cli/bin/babel.js", "--watch",
        # where you'd like to keep your React components
        "web/static/js/components",
        # where you'd like to store them after compilation.
        # This MUST match your compiled_path config from config/config.exs.
        "--out-dir", "priv/static/js/components",
        "--presets=env,react"
      ]
    ]
  ```

  Add the same command to your deploy script (after `brunch build --production`).

  ### `package.json`

  ```
  {
    // ...
    "scripts": {
      "deploy": "brunch build --production; babel web/static/js/components --out-dir priv/static/js/components --presets=env,react",
      "watch": "brunch watch --stdin"
    },
    // ...
  }
  ```

  ## Usage

  In your Phoenix controller, you can get the rendered HTML and pass that on to your views.

  ```
  def YourApp.PageController do
    use YourApp.Web, :controller

    def index(conn, _params) do
      people = ["Joe", "Robert", "Other Joe"]
      html = ReactPhoenix.ServerSide.react_component("hello", %{people: people})
      render(conn, "index.html", react_html: html, people: people)
    end
  end
  ```

  Once you are in your view, you can then render that HTML and then mount the component client-side.
  See `ReactPhoenix.ClientSide` for more information.

  ```
  <div id="hello"><%= @react_html %></div>
  <%= ReactPhoenix.ClientSide.react_component("Components.Hello", %{people: @people}, target_id: "hello") %>
  ```
  """
  @path_prefix Application.get_env(:react_phoenix, :compiled_path)

  @doc """
  Generate a String that contains the HTML of a rendered React component.

  It returns a String that is suitable for passing to a Phoenix view for rendering.
  `filename` should be, along with the `path_prefix` configured for your application,
  where your compiled React component can be found.

  For example, if you configured your app with `config :react_pheonix, compiled_path: "priv/static/js/components"`
  and you have a component file compiled there with the name of `hello_react.js`, you would pass `"hello_react"` as `filename`.
  """
  def react_component(filename, props \\ %{}) do
    path = Path.join(@path_prefix, "#{filename}.js")
    ReactPhoenix.ReactIo.json_call!(%{
      component: path,
      props: props
    })
    |> Map.get("html")
  end
end
