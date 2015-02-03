defmodule Fibex do
  def main(argv) do
    argv |> Enum.map(&(String.to_integer(&1))) |> run
  end
  
  def run(ns) do
    ns
    |> Enum.with_index
    |> Enum.map fn(ni) ->
      Fibex.Fn.spawn_run(self, ni)
    end

    receive_fibs(length(ns), [])
  end

  defp receive_fibs(lns, result) do
    receive do
      fib ->
        result = [fib | result]

        if lns == 1 do
          IO.puts(print_fibs(result))
        else
          receive_fibs(lns - 1, result)
        end
    end
  end

  defp print_fibs(fibs) do
    fibs
    |> Enum.sort(fn({_, a}, {_, b}) -> a < b end)
    |> Enum.map(fn({f, _}) -> f end)
    |> inspect
  end
end
