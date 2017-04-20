# ReactPhoenix

Functions to make rendering React components easy in Phoenix.

Combined with the javascript also included in this package, rendering React
components in your Phoenix views is now much easier. The module was built
with Brunch in mind (vs Webpack). Since Phoenix uses Brunch by default, this
package can make getting React into your application much faster than
switching over to a different system.


## Installation in 3 (or 4) EASY STEPS!

This package is meant to be quick and painless to install into your Phoenix
application. It is assumed that you have already brought React into your
application through `npm`. Here are the 3 steps:

### 1. Declare the dependency

The package can be installed by adding `react_phoenix` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [{:react_phoenix, "~> 0.2.0"}]
end
```

After adding to your mix file, run:

```
> mix deps.get
```

### 2. Add the javascript dependency to package.json

In order to correctly render a React component in your view templates, a
provided javascript file must be included in your `package.json` file in
the dependencies section. It might look like this:

```
{
  ...
  "dependencies": {
    "babel-preset-react": "^6.23.0",
    "minions.css": "^0.3.1",
    "phoenix": "file:deps/phoenix",
    "phoenix_html": "file:deps/phoenix_html",
    "react": "^15.4.2",
    "react-dom": "^15.4.2",

    "react_phoenix": "file:deps/react_phoenix" <-- ADD THIS!
  },
  ...
}
```

Then run
```
> npm install
```

### 3. Import and initialize the javascript helper

In your main application javascript file (usually `web/static/js/app.js`), add the
following lines:

```javascript
import ReactPhoenix from "react-phoenix"
ReactPhoenix.init()
```

Note that `ReactPhoenix.init()` SHOULD likely be at the bottom of this file and MUST
be below any React components registered in the global namespace and used in your view
templates (see *Usage* below).

### 4. (optional) Import the module into your views for less typing

If you'd like to just call `react_component(...)` instead of the full
`ReactPhoenix.react_component(...)`, you can import `ReactPhoenix` into your `web/web.ex`
views section. It might look like this:

```elixir
def view do
  quote do
    use Phoenix.View, root: "web/templates"

    import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

    use Phoenix.HTML

    import MyPhoenixApp.Router.Helpers
    import MyPhoenixApp.ErrorHelpers
    import MyPhoenixApp.Gettext

    import ReactPhoenix # <-- ADD THIS!
  end
end
```


## Usage

Once installed, you can use `react_component` in your views by:

1. Making sure that the component you'd like rendered is in the global namespace.
   You can do that in `app.js` like this (for example):
   
   ```javascript
   import MyComponent from "./components/my_component"
   window.Components = {
     MyComponent
   }
   
   // these should be below your components
   import ReactPhoenix from "react-phoenix"
   ReactPhoenix.init()
   ```

2. In your view template, you can then render it like this:

   ```elixir
   # with no props
   <%= ReactPhoenix.react_component("Components.MyComponent") %>

   # with props
   <%= ReactPhoenix.react_component("Components.MyComponent", %{language: "elixir", awesome: true}) %>

   # with no props and a target html element id option
   <%= ReactPhoenix.react_component("Components.MyComponent", %{}, target_id: "my-react-span") %>
   ```
   
   This will render a special `div` element in your html output that will then be recognized by the
   javascript helper as a div that should be turned into a React component. It will then render the
   named component in that `div` (or a different element specified by ID via the `target_id` option).


## Troubleshooting

### I keep getting a compilation error like this

```
  19 Apr 20:52:40 - error: Compiling of web/static/js/component.js failed. SyntaxError: web/static/js/component.js: Unexpected token (10:6)
   8 |   render() {
   9 |     return (
> 10 |       <h1>You rendered React!</h1>
     |       ^
  11 |     )
  12 |   }
  13 | } ^G
```

  Most likely, you haven't set up your brunch config to know how to handle JSX files. I recommend
  the following:

  1. Run `npm install babel-preset-react babel-preset-env --save`
  2. Modify your `brunch-config.js` file to include those presets

      ```js
      // ...
      // Configure your plugins
      plugins: {
        babel: {
          presets: ["env", "react"], // <-- ADD THIS!
          // Do not use ES6 compiler in vendor code
          ignore: [/web\/static\/vendor/]
        }
      },
      // ...
      ```


## Documentation and other stuff

This package is heavily inspired by the [react-rails](https://github.com/reactjs/react-rails) project.

For more detailed documentation, check out the hex docs at 
[https://hexdocs.pm/react_phoenix](https://hexdocs.pm/react_phoenix)
