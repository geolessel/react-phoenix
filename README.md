# ReactPhoenix

[![Build Status](https://travis-ci.org/geolessel/react-phoenix.svg?branch=master)](https://travis-ci.org/geolessel/react-phoenix)
[![Hex.pm](https://img.shields.io/hexpm/v/react_phoenix.svg)](https://hex.pm/packages/react_phoenix)

Functions to make rendering React.js components easy in Phoenix.

Combined with the javascript also included in this package, rendering React
components in your Phoenix views is now much easier. The module was built
with Brunch in mind (vs Webpack). Since Phoenix uses Brunch by default, this
package can make getting React into your application much faster than
switching over to a different system.


> Note regarding Phoenix versions < 1.3
>
> This README is written as a guide for Phoenix apps running Phoenix >= 1.3. If you are using a
> version of Phoenix below version 1.3, you can check out the [Phoenix 1.2 README](README-phoenix-1.2.md).


## Installation in 4 (or 5) EASY STEPS!

This package is meant to be quick and painless to install into your Phoenix application.


### 1. Declare the dependency

The package can be installed by adding `react_phoenix` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [{:react_phoenix, "~> 0.5.0"}]
end
```

After adding to your mix file, run:

```
> mix deps.get
```

### 2. Add the javascript dependency to package.json

In order to correctly render a React component in your view templates, a
provided javascript file must be included in your `assets/package.json` file in
the dependencies section. It might look like this:

```
{
  ...
  "dependencies": {
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html",

    "react-phoenix": "file:../deps/react_phoenix" <-- ADD THIS!
  },
  ...
}
```

Then run (from your `assets` directory)

```
> npm install
```


### 3. Make sure React and Babel presets are installed

Since we want React and would like to write JSX in our app, we need
to make sure we get the packages brunch needs in order to compile our files.

```
> npm install react babel-preset-env babel-preset-react --save
```

We also need to activate those presets from our `assets/brunch-config.js` file:

```js
// ...
// Configure your plugins
plugins: {
  babel: {
    presets: ["env", "react"], // <-- ADD THIS!
    // Do not use ES6 compiler in vendor code
    ignore: [/vendor/]
  }
},
// ...
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
   # this can be used for server-side rendering (continuing with example from that section above)
   <span id="my-react-span"><%= @react_html %></span>
   <%= ReactPhoenix.ClientSide.react_component("Components.Characters", %{people: people}, target_id: "my-react-span") %>
   ```
   
   This will render a special `div` element in your html output that will then be recognized by the
   javascript helper as a div that should be turned into a React component. It will then render the
   named component in that `div` (or a different element specified by ID via the `target_id` option).


## What about server-side rendering?

Server-side rendering is a bit of a bear to get right with brunch. In fact, there was a previous version (0.4.3) of
`react-phoenix` that included an attempt at server-side rendering. It worked locally for me, but only after many
attempts to get it right. In the end, there was a specific set of hand-wavy things you needed to do to get it working
and I removed all the server-side code from the master branch for now.

I may have some time freed up in the future to attempt to tackle it again. But for the simplicity of installation and usage, client-side
rendering is likely all you'll need for now.


## Documentation and other stuff

This package is heavily inspired by the [react-rails](https://github.com/reactjs/react-rails) project.

For more detailed documentation, check out the hex docs at 
[https://hexdocs.pm/react_phoenix](https://hexdocs.pm/react_phoenix)
