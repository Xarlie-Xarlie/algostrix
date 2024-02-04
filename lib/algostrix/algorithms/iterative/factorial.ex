defmodule Algostrix.Algorithms.Iterative.Factorial do
  @moduledoc """
  Factorial is a function that multiplies the given number down to 1.

  Examples:
    f(n) = n! -> n \\* (n-1) \\* (n-2) \\* ... \\* 1

    For a real number n, f(n) returns its factorial.

    f(5) = 120 = 5 \\* 4 \\* 3 \\* 2 \\* 1

  For this factorial implementation, we use iteration.
  It means we cycle through n..1, multiplying each number.

  The final result is the factorial of n, f(n).
  """

  @doc """
  Calculates the factorial of a positive number.

  ## Examples:

      iex> alias Algostrix.Algorithms.Recursive.Factorial

      iex> Factorial.call(5)
      120

      iex> Factorial.call(7)
      5040

      iex> Factorial.call(1_000_000)
      (SystemLimitError) a system limit has been reached
  """
  @spec call(number :: pos_integer()) :: pos_integer()
  def call(0), do: 1

  def call(number) when is_integer(number) and number > 0 do
    Enum.reduce(number..1, 1, &(&1 * &2))
  end
end
