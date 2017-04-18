# ReactPhoenix

Simple helper functions to allow you to easily render React components
in your Phoenix views. This is developed on top of brunch.

The documentation is sparse in this 0.1 release, but here's the quick and dirty.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `react_phoenix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:react_phoenix, "~> 0.1.1"}]
end
```

After adding to your mix file, run:

```
> mix deps.get
> mix compile
> mix react_phoenix.install
```

This will install the main javascript file that allows this library to work as
well as adding two lines to your web/static/js/app.js file that imports
react_phoenix and calls it's main function.

This is inserted at the bottom of the file AND SHOULD LIKELY STAY THERE.

## Usage

Once that is done, you can use it in your views by:

1. Making sure that the component you'd like rendered is in the global namespace.
   You can do that in `app.js` like this:
   
   ```javascript
   import MyComponent from "./components/my_component"
   window.Components = {
     MyComponent
   }
   ```
2. In your view template, you can then render it like this:

   ```elixir
   <%= ReactPhoenix.render_component("Components.MyComponent", %{any: "props", you: "need"}) %>
   # or
   <%= ReactPhoenix.render_component("Components.MyComponent", any: "props", you: "need") %>
   ```
3. To save some typing, you can also add `import ReactPhoenix` in the `view`
   section of your web/web.ex file. If you do so, you can just call

   ```elixir
   <%= render_component(...) %>
   ```

[https://hexdocs.pm/react_phoenix](https://hexdocs.pm/react_phoenix)

