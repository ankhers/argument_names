defmodule ArgumentNames do
  @moduledoc """
  Documentation for `ArgumentNames`.
  """

  @doc """
  Defines a public function with named arguments

  ## Examples

    defmodule Foo do
      require ArgumentNames
      import ArgumentNames
    
      defnamed div(first, second) do
        first / second
      end
    end

    Foo.div(2, 4)
    #=> 0.5

    Foo.div(second ~> 4, 2)
    #=> 0.5
  """
  defmacro defnamed({name, meta, args} = call, do: expr) do
    name_and_args = {:"call_#{name}", meta, args}

    outer_args = Macro.escape(args)

    quote do
      @doc false
      def unquote(name_and_args) do
        unquote(expr)
      end

      defmacro unquote(call) do
        ArgumentNames.do_call_function(unquote(outer_args), unquote(args), unquote(name), __MODULE__)
      end
    end
  end

  @doc """
  Defines a private function with named arguments

  ## Examples

  defmodule Foo do
    require ArgumentNames
    import ArgumentNames
    
    defnamedp div(first, second) do
      first / second
    end
  end
  """
  defmacro defnamedp({name, meta, args} = call, do: expr) do
    name_and_args = {:"call_#{name}", meta, args}

    outer_args = Macro.escape(args)

    quote do
      @doc false
      defp unquote(name_and_args) do
        unquote(expr)
      end

      defmacrop unquote(call) do
        ArgumentNames.do_call_function(unquote(outer_args), unquote(args), unquote(name))
      end
    end
  end

  @doc false
  def do_call_function(outer_args, args, name, mod \\ nil) do
    split_args =
      args
      |> Enum.group_by(fn
      {:~>, _, _} -> true
      _ -> false
    end)

      arr =
        List.foldl(split_args[true] || [], :array.new(length(args)), fn
          {:~>, _, [{var_name, _, _}, val]}, acc ->
            idx =
            Enum.find_index(outer_args, fn {outer_name, _, _} ->
              var_name == outer_name
            end)

          :array.set(idx, val, acc)
        end)

      arr =
        List.foldl(split_args[false] || [], arr, fn
          val, acc ->
            set_array(0, acc, val)
        end)

      case mod do
        nil ->
          {:"call_#{name}", [], :array.to_list(arr)}
        _ ->
          {{:., [], [
               {:__aliases__, [alias: false], [mod]},
               :"call_#{name}"
             ]}, [], :array.to_list(arr)}
      end
  end

  @doc false
  def set_array(idx, array, val) do
    if :array.get(idx, array) == :undefined do
      :array.set(idx, val, array)
    else
      set_array(idx + 1, array, val)
    end
  end
end
