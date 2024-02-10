defmodule Algostrix.Algorithms.Sorting.Selection do
  @moduledoc """
  Selection Sort Algorithm.

  Selection sort is a simple comparison-based sorting algorithm that divides the input list into two parts: sorted and unsorted. 
  The algorithm repeatedly selects the minimum element from the unsorted portion and moves it to the beginning of the sorted part. 
  This process continues until the entire list is sorted. Selection sort has an average and worst-case time complexity of O(n^2) and 
  space complexity of O(1), making it inefficient for large datasets but suitable for small lists or as a teaching example.
  """

  @doc """
  Sort a list of numbers using the Selection Sort algorithm.

  ## Examples:
    
      iex> Algostrix.Algorithms.Sorting.Selection.sort([99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0])
      [0, 1, 2, 4, 5, 6, 44, 63, 87, 99, 283]
  """
  @spec sort([number()]) :: [number()]
  def sort([]), do: []
  def sort([single]), do: [single]

  def sort([head | tail] = list) do
    selection_sort(head, tail, [], list)
  end

  @spec selection_sort(number(), [number()], [number()], [number()]) :: [number()]
  defp selection_sort(pivot, [head | tail], acc, list) when pivot > head do
    selection_sort(head, tail, acc, list)
  end

  defp selection_sort(pivot, [head | tail], acc, list) when pivot <= head do
    selection_sort(pivot, tail, acc, list)
  end

  defp selection_sort(pivot, [], acc, list) do
    case List.delete(list, pivot) do
      [] ->
        [pivot | acc]

      remaining ->
        selection_sort(hd(remaining), tl(remaining), [pivot | acc], remaining)
    end
  end
end
