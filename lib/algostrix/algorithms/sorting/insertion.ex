defmodule Algostrix.Algorithms.Sorting.Insertion do
  @moduledoc """
  Insertion Sort Algorithm.

  Insertion sort is a simple comparison-based sorting algorithm that builds the final sorted array one element at a time. 
  It iterates through the input list, removing one element at a time and finding the correct position to insert it into 
  the already sorted part of the array. The algorithm has an average and worst-case time complexity of O(n^2) and 
  space complexity of O(1), making it inefficient for large datasets but suitable for small lists or as a teaching example.
  """

  @doc """
  Sorts a list of numbers using the Insertion Sort algorithm.

  ## Examples:
    
      iex> Algostrix.Algorithms.Sorting.Insertion.sort([99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0])
      [0, 1, 2, 4, 5, 6, 44, 63, 87, 99, 283]
  """
  @spec sort([number()]) :: [number()]
  def sort([]), do: []
  def sort([single]), do: [single]

  def sort(numbers) do
    Enum.reduce(numbers, [], fn element, acc ->
      Enum.find_index(acc, &(&1 > element))
      |> case do
        nil -> List.insert_at(acc, -1, element)
        index -> List.insert_at(acc, index, element)
      end
    end)
  end
end
