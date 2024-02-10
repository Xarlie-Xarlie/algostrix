defmodule Algostrix.Algorithms.Sorting.Bubble do
  @moduledoc """
  Bubble Sort algorithm implementation.

  This module provides an implementation of the Bubble Sort algorithm in Elixir.
  Bubble Sort repeatedly steps through the list, compares adjacent elements, and 
  swaps them if they are in the wrong order. The process is repeated until the list 
  is sorted.

  This implementation uses recursion due to Elixir's functional nature, as iteration 
  over lists differs from imperative languages.
  """

  @doc """
  Sort a list of numbers using the Bubble Sort algorithm.

  ## Examples:
    
      iex> alias Algostrix.Algorithms.Sorting.Bubble
      iex> Bubble.sort([99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0])
      [0, 1, 2, 4, 5, 6, 44, 63, 87, 99, 283]
  """
  @spec sort([number()]) :: [number()]
  def sort([]), do: []
  def sort([single]), do: [single]

  def sort(list) do
    {new_list, swapped} = bubble(list)
    if swapped, do: sort(new_list), else: new_list
  end

  @spec bubble([number()]) :: {[number()], boolean()}
  defp bubble([head, next | tail]) when head > next do
    {rest, _swapped} = bubble([head | tail])
    {[next | rest], true}
  end

  defp bubble([head | tail]) do
    {rest, swapped} = bubble(tail)
    {[head | rest], swapped}
  end

  defp bubble([]), do: {[], false}
end
