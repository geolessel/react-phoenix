# ReactPhoenix

[![Build Status](https://travis-ci.org/geolessel/react-phoenix.svg?branch=master)](https://travis-ci.org/geolessel/react-phoenix)
[![Hex.pm](https://img.shields.io/hexpm/v/react_phoenix.svg)](https://hex.pm/packages/react_phoenix)

Functions to make rendering React.js components easy in Phoenix.

Combined with the javascript also included in this package, rendering React
components in your Phoenix views is now much easier. Using the Phoenix default
of Webpack, this package can make getting React into your application much
faster than switching over to a different system.

> Note regarding Phoenix version 1.3
>
> Phoenix 1.3 and earlier use Brunch by default instead of Webpack for asset compilation.
> The setup for apps using Brunch is different than apps using Webpack. If you'd like to
> read the old guide for 1.3/Brunch, you can read the [Phoenix 1.3 README](README-phoenix-1.3.md).

> Note regarding Phoenix versions < 1.3
>
> This README is written as a guide for Phoenix apps running Phoenix >= 1.3. If you are using a
> version of Phoenix below version 1.3, you can check out the [Phoenix 1.2 README](README-phoenix-1.2.md).


## Installation in 4 (or 5) EASY STEPS!

This package is meant to be quick and painless to install into your Phoenix application.
It is a thin wrapper to call the React render function from your Phoenix template and
assumes you already have React in your project.


### 1. Declare the dependency

The package can be installed by adding `react_phoenix` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:react_phoenix, github: "geolessel/react-phoenix", branch: "webpack"}
  ]
end
```

After adding to your mix file, run:

```
mix deps.get
```

### 2. Add the javascript dependency to package.json

In order to correctly render a React component in your view templates, a
provided javascript file must be included in your `assets/package.json` file in
the dependencies section. It might look like this:

```js
{
  ...
  "dependencies": {
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html",
    "react": "^16.2.0",
    "react-dom": "^16.2.0",
    "react-phoenix": "file:../deps/react_phoenix" <-- ADD THIS!
  },
  ...
}
```

Then run (from your `assets` directory)

```
npm install
```


### 3. Make sure React and Babel presets are installed

Since we want React and would like to write JSX in our app, we need
to make sure we get the packages brunch needs in order to compile our files.

```
npm install react react-dom babel-preset-env babel-preset-react --save
```

We also need to activate those presets from the `assets/.babelrc` file:

```js
// Configure your plugins
{
  "presets": [
    "env",
    "react" // <-- ADD THIS!
  ]
}
```

### 4. Import and initialize the javascript helper

In your main application javascript file (usually `assets/js/app.js`), add the
following line:

```javascript
import "react-phoenix"
```

### 5. (optional) Import the module into your views for less typing

If you'd like to just call `react_component(...)` in your views instead of the full
`ReactPhoenix.ClientSide.react_component(...)`, you can import `ReactPhoenix.ClientSide`
into your `lib/APPNAME_web.ex` views section. It might look like this:

```elixir
def view do
  quote do
    use Phoenix.View, root: "web/templates"

    import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

    use Phoenix.HTML

    import MyPhoenixApp.Router.Helpers
    import MyPhoenixApp.ErrorHelpers
    import MyPhoenixApp.Gettext

    import ReactPhoenix.ClientSide # <-- ADD THIS!
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
   ```

2. In your view template, you can then render it like this:

   ```elixir
   # with no props
   <%= ReactPhoenix.ClientSide.react_component("Components.MyComponent") %>

   # with props
   <%= ReactPhoenix.ClientSide.react_component("Components.MyComponent", %{language: "elixir", awesome: true}) %>

   # with props and a target html element id option
   <span id="my-react-span"><%= @react_html %></span>
   <%= ReactPhoenix.ClientSide.react_component("Components.Characters", %{people: people}, target_id: "my-react-span") %>
   ```

   This will render a special `div` element in your html output that will then be recognized by the
   javascript helper as a div that should be turned into a React component. It will then render the
   named component in that `div` (or a different element specified by ID via the `target_id` option).


## What about server-side rendering?

I couldn't quite get this working with Brunch, but I hope to have time to look at it again with Webpack.


## Documentation and other stuff

This package is heavily inspired by the [react-rails](https://github.com/reactjs/react-rails) project.

For more detailed documentation, check out the hex docs at
[https://hexdocs.pm/react_phoenix](https://hexdocs.pm/react_phoenix)
