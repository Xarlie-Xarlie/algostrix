defmodule AlgoStrix.Extras do
  @moduledoc """
  Merge two sorted arrays keeping the sorting in the result.
  """

  @doc """
  Merge two sorted arrays keeping the sorting in the result.

  Goal Example:
    list_one = [0, 3, 4, 31]
    list_two = [4, 5, 6, 30, 32]

    merge_sorted_lists(list_one, list_two)
    [32, 31, 30, 6, 5, 4, 4, 3, 0]

  This implementation returns a list in descending order.
  The descending order is keeped due to Tail Call Optimization.

  If the ascending order is need just add an Enum.reverse/1 in the last clause.
  """
  @spec merge_sorted_lists(
          list_one :: [integer()],
          list_two :: [integer()],
          acc :: [integer()] | []
        ) :: [integer()] | []
  def merge_sorted_lists(list_one, list_two, acc \\ [])

  def merge_sorted_lists([f_one | tail_one], [f_two | tail_two], acc) when f_one <= f_two do
    merge_sorted_lists(tail_one, [f_two | tail_two], [f_one | acc])
  end

  def merge_sorted_lists([f_one | tail_one], [f_two | tail_two], acc) when f_one > f_two do
    merge_sorted_lists([f_one | tail_one], tail_two, [f_two | acc])
  end

  def merge_sorted_lists([], [f_two | tail_two], acc) do
    merge_sorted_lists([], tail_two, [f_two | acc])
  end

  def merge_sorted_lists([f_one | tail_one], [], acc) do
    merge_sorted_lists(tail_one, [], [f_one | acc])
  end

  def merge_sorted_lists([], [], acc), do: acc
end
