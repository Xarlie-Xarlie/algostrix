defmodule Algostrix.Algorithms.Sorting.Quick do
  @moduledoc """
  This module implements the Quick Sort algorithm.

  Quick Sort is a comparison-based sorting algorithm that divides the input list into smaller 
  sublists around a chosen pivot element. It then recursively sorts the sublists and combines them 
  to produce the final sorted list. Quick Sort has an average and best-case time complexity of O(n log n), 
  making it efficient for sorting large datasets. However, in the worst case, it can have a time complexity 
  of O(n^2) if poorly chosen pivot elements are used. Despite this, Quick Sort is widely used due to its 
  efficiency and simplicity.
  """

  @doc """
  Sorts a list of numbers using the Quick Sort algorithm.

  ## Examples

      iex> Algostrix.Algorithms.Sorting.Quick.sort([4, 2, 7, 1, 5])
      [1, 2, 4, 5, 7]

  """
  @spec sort([number()]) :: [number()]
  def sort([]), do: []
  def sort([single]), do: [single]

  def sort(numbers) do
    {left, right} =
      Enum.split(numbers, -1)

    quick(left, right, [])
  end

  @spec quick([number()], [number()], [number()]) :: [number()]
  defp quick([head | tail], [pivot | pivot_tail], acc) when head >= pivot do
    quick(tail, [pivot, head | pivot_tail], acc)
  end

  defp quick([head | tail], [pivot | pivot_tail], acc) when head < pivot do
    quick(tail, [pivot | pivot_tail], [head | acc])
  end

  defp quick([], [head | tail], acc) do
    sort(acc) ++ [head | sort(tail)]
  end
end
