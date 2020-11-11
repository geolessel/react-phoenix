defmodule ReactPhoenix.ClientSide do
  @moduledoc """
  Functions to make rendering React components easy in Phoenix views.

  Combined with the javascript also included in this package, rendering React
  components in your Phoenix views can be much easier. The module was built
  with Brunch in mind (vs Webpack). Since Phoenix uses Brunch by default, this
  package can make getting React into your application much faster than
  switching over to a different system.
  """

  import Phoenix.HTML.Tag

  @doc """
  Generate a div containing the named React component with no props or options.

  Returns safe html: `{:safe, [60, "div", ...]}`.

  You can utilize this in your Phoenix views:

  ```
  <%= ReactPhoenix.ClientSide.react_component("MyComponent") %>
  ```

  The resulting `<div>` tag is formatted specifically for the included javascript
  helper to then turn into your named React component.
  """
  @spec react_component(name :: String.t()) :: Phoenix.HTML.safe()
  def react_component(name), do: react_component(name, %{})

  @doc """
  Generate a div containing the named React component and pass it props.

  Returns safe html: `{:safe, [60, "div", ...]}`.

  Props can be passed in as a Map or a List.

  You can utilize this in your Phoenix views:

  ```
  <%= ReactPhoenix.ClientSide.react_component("MyComponent", %{language: "elixir", awesome: true}) %>
  ```

  The resulting `<div>` tag is formatted specifically for the included javascript
  helper to then turn into your named React component and then pass in the props specified.

  Since a unique `id` is required for LiveView to track its state, a random numeric
  id is assigned.
  """
  @spec react_component(name :: String.t(), props :: list | map) :: Phoenix.HTML.safe()
  def react_component(name, props) when is_list(props) do
    react_component(name, Enum.into(props, %{}))
  end

  def react_component(name, props) when is_map(props) do
    props = Jason.encode!(props)

    content_tag(:div, "", [
      {:data, [react_class: name, react_props: props]},
      id: :rand.uniform_real(),
      phx_hook: "ReactPhoenix",
      phx_update: "ignore"
    ])
  end

  @doc """
  Generate a div containing the named React component and pass it props and options.

  Returns safe html: `{:safe, [60, "div", ...]}`.

  For now, props MUST be passed in as a Map. The only option currently accepted is `target_id`.
  If you pass in a `target_id`, the resulting `<div>` tag will tell the javascirpt helper
  which HTML element you'd like to render the React component. This is helpful in scenarios
  like server-side rendering of a component.

  You can utilize this in your Phoenix views:

  ```
  <%= ReactPhoenix.ClientSide.react_component(
        "MyComponent",                        # <- component name
        %{language: "elixir", awesome: true}, # <- props
        target_id: "react-div"                # <- options
      ) %>
  ```

  The resulting `<div>` tag is formatted specifically for the included javascript
  helper to then turn into your named React component and then pass in the props specified.

  Since a unique `id` is required for LiveView to track its state, a random numeric
  id is assigned.

  ## Options

  You can pass a Keyword list of options that controls the rendering of the final html element
  that the react component will be rendered into.

  * `target_id` - If you have a rendered html element already on your page with a unique `id`
    attribute, this will render your react component into _that_ already-existing element
    instead of creating one of its own. The default is an empty string, which will cause it
    to render into its own created element.
  * `html_element` - By default, `ReactPhoenix.ClientSide.react_component/3` will create a
    `div` for output in your template. If you'd rather use a different element (`span`, `ul`, etc.),
    you can specify it here as an atom (e.g. `:span`, `:ul`, etc.).

  Anything else you pass in will be further passed directly to the html element it
  creates as attributes. This allows you more control over the element. Some useful examples
  of what you would specify are `class`, `id`, `style`, etc.
  """
  @spec react_component(name :: String.t(), props :: map, opts :: list()) ::
          Phoenix.HTML.safe()
  def react_component(name, props, opts) when is_map(props) do
    props = Jason.encode!(props)
    id = :rand.uniform_real()

    {html_element, opts} = Keyword.pop(opts, :html_element, :div)
    {target_id, opts} = Keyword.pop(opts, :target_id, id)

    content_tag(
      html_element,
      "",
      Keyword.merge(
        [
          {:data, [react_class: name, react_props: props, react_target_id: target_id]},
          id: id,
          phx_hook: "ReactPhoenix",
          phx_update: "ignore"
        ],
        opts
      )
    )
  end
end
