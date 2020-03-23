defmodule Chapter5.Fibonacci do
  @doc """
  ## Examples
    iex> Fibonacci.sequence(10)
    [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def sequence(n) when n >= 0 do
    Stream.unfold({0, 1}, fn {n1, n2} ->
      {n1, {n2, n1 + n2}}
    end)
    |> Enum.take(n)
  end
end
