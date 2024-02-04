defmodule Algostrix.Algorithms.Iterative.Fibonacci do
  @moduledoc """
  Fibonacci is a function where the terms are sums
  of the two previous ones, starting from 0 and 1.

  ## Examples:

      - We can define the Fibonacci function f(n):
        f(n) is the n'th term in the Fibonacci series.

      - f(3) = 2 -> 0, 1, 1, 2
        Here we have 2, which is the sum of 0 + 1 + 1.

      - f(n) = cycle through 0 to n, sum last, acc.
        Update last = acc, acc = last + acc.

  This is the Iterative approach of Fibonacci for n.
  """

  @doc """
  Returns the Fibonacci number given its index.
  Using an Iterative approach.

  Cycle through the interval from 0 to n.
  Sum the values, update the last and accumulated terms.

  ## Examples:

      iex> alias Algostrix.Algorithms.Iterative.Fibonacci

      iex> Fibonacci.call(5)
      5

      iex> Fibonacci.call(3)
      2

      iex> Fibonacci.call(9)
      34

      iex> Fibonacci.call(10)
      55
  """
  @spec call(0 | pos_integer()) :: 0 | pos_integer()
  def call(n) when n >= 0 do
    Enum.reduce(0..n, {0, 1}, fn
      0, {0, 1} -> {0, 1}
      _nth_term, {last, acc} -> {acc, last + acc}
    end)
    |> elem(0)
  end
end
