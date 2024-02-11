defmodule Algostrix.Algorithms.Sorting.Merge do
  @moduledoc """
  This module implements the Merge Sort algorithm.

  Merge Sort is a divide-and-conquer algorithm that divides the input list into two halves, 
  recursively sorts each half, and then merges the sorted halves. 
  It has a time complexity of O(n log n) and is often preferred for its stability 
  and predictable performance.

  For sorting an empty list or a list with a single element, the result is the same list.
  """

  @spec sort([number()]) :: [number()]
  @doc """
  Sorts a list of numbers using the Merge Sort algorithm.

  ## Examples

      iex> Algostrix.Algorithms.Sorting.Merge.sort([4, 2, 7, 1, 5])
      [1, 2, 4, 5, 7]
  """
  def sort([]), do: []
  def sort([single]), do: [single]

  def sort(numbers) do
    size = length(numbers)
    mid = div(size, 2)
    {left, right} = Enum.split(numbers, mid)
    merge(sort(left), sort(right))
  end

  @spec merge([number()], [number()]) :: [number()]
  defp merge([], right), do: right
  defp merge(left, []), do: left

  defp merge([lh | lt], [rh | rt]) when lh <= rh do
    [lh | merge(lt, [rh | rt])]
  end

  defp merge(left, [rh | rt]), do: merge([rh | left], rt)
end
