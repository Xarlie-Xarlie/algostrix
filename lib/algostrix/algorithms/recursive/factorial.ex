defmodule Algostrix.Algorithms.Recursive.Factorial do
  @moduledoc """
  Factorial is a function that multiplies the given number down to 1.

  ## Examples:

    f(n) = n! -> n \\* (n-1) \\* (n-2) \\* ... \\* 1

    For a real number n, f(n) returns its factorial.

    f(5) = 120 = 5 \\* 4 \\* 3 \\* 2 \\* 1

    As you can see:
      - f(5) = 5 \\* f(4) = 5 \\* 4 \\* f(3) and so on.

  For this factorial implementation, we use recursion.
  It means, for f(n), it returns n \\* f(n-1).

  When it reaches f(0), it returns 1, f(0) = 1.

  The final result is the factorial of n, f(n).
  """

  @doc """
  Calculates the factorial of a positive number.
  Using a recursive approach.

  The base case is 0, which returns the accumulator.
  For any other case, the function calls itself
  with (number - 1).

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
  def call(number) when is_integer(number) and number >= 0 do
    do_factorial(number, 1)
  end

  @spec do_factorial(pos_integer() | 0, pos_integer()) :: pos_integer()
  defp do_factorial(0, acc), do: acc
  defp do_factorial(number, acc), do: do_factorial(number - 1, acc * number)
end
