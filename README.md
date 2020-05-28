# Argument Names

An easy to use and pipe friendly way to have named arguments

## Examples

Suppose we have the following module

```elixir
defmodule Foo do
  require ArgumentNames
  import ArgumentNames
  
  defnamed div(first, second) do
    first / second
  end
end
```

We can then start using the `first` and `second` names within our function calls.

```elixir
require Foo
Foo.div(second ~> 4, 2) => 0.5
```

We can also use this with pipes in order to change around our argument order

```elixir
4 |> Foo.div(first ~> 2) => 0.5
2 |> Foo.div(second ~> 4) => 0.5
```

We can also use this function with pipes without having to name the arguments

```elixir
2 |> Foo.div(4) => 0.5
```

## Roadmap

These are just a couple things I would like to see added to this package in no particular order

* Support for making named private functions
* Default arguments

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `argument_names` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:argument_names, "~> 0.1.0"}
  ]
end
```
