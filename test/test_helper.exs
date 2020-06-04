defmodule Helpers do
  require ArgumentNames
  import ArgumentNames

  defnamed named(a, b, c) do
    [a, b, c]
  end

  defnamed private(a, b, c) do
    named(a ~> a, c ~> c, b)
  end
end

ExUnit.start()
