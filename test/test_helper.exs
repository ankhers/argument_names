defmodule Helpers do
  require ArgumentNames
  import ArgumentNames

  defnamed named(a, b, c) do
    [a, b, c]
  end
    
  defnamedp do_private(a, b, c) do
    [a, b, c]
  end

  defnamed private(a, b, c) do
    do_private(a ~> a, c ~> c, b)
  end

end

ExUnit.start()
