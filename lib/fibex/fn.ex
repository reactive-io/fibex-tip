defmodule Fibex.Fn do
  def spawn_run(pid, ni) do
    spawn __MODULE__, :send_run, [pid, ni]
  end

  def send_run(pid, {n, i}) do
    send pid, {run(n), i}
  end

  def run(n) do
    run(n, 1, 0)
  end

  defp run(0, _, _) do
    0
  end
  defp run(1, a, b) do
    a + b
  end
  defp run(n, a, b) do
    run(n - 1, b, a + b)
  end
end
