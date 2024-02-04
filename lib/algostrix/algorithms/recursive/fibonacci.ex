defmodule Algostrix.Algorithms.Recursive.Fibonacci do
  @moduledoc """
  Fibonacci is a function where the terms are sums
  of the two previous ones, starting from 0 and 1.

  ## Examples:

      - We can define the Fibonacci function f(n):
        f(n) is the n'th term in the Fibonacci series.

      - f(3) = 2 -> 0, 1, 1, 2
        Here we have 2, which is the sum of 1 + 1.
        The second and third terms of the sequence.

      - f(n) = f(n - 1) + f(n - 2)
        For the index n, we have to sum the values
        of f(n-1) and f(n-2).

      - f(3) = f(2) + f(1)
      - f(3) = (f(1) + f(0)) + f(1)
      - f(3) = (1 + 0) + 1 = 2

  For this Fibonacci implementation, we use recursion.
  It means, for f(n), it returns f(n-1) + f(n-2).
  """

  @doc """
  Returns the Fibonacci number given its index.
  Using a recursive approach.

  For tail call optimization, it sums the past
  two terms and moves forward with a new accumulator.

  ## Examples:

      iex> alias Algostrix.Algorithms.Recursive.Fibonacci

      iex> Fibonacci.call(3)
      2

      iex> Fibonacci.call(5)
      5

      iex> Fibonacci.call(9)
      34

      iex> Fibonacci.call(10)
      55
  """
  @spec call(pos_integer() | 0) :: 0 | pos_integer()
  def call(n) when n >= 0 do
    do_fibonacci(n, 0, 1)
  end

  @spec do_fibonacci(0 | pos_integer(), 0 | pos_integer(), pos_integer()) :: 0 | pos_integer()
  defp do_fibonacci(0, last, _acc), do: last
  defp do_fibonacci(1, _last, acc), do: acc
  defp do_fibonacci(n, last, acc), do: do_fibonacci(n - 1, acc, last + acc)
end
