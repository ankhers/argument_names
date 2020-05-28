defmodule Helpers do
  require ArgumentNames
  import ArgumentNames

  defnamed named(a, b, c) do
    [a, b, c]
  end
end

ExUnit.start()
