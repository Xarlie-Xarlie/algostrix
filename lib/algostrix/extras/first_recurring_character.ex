defmodule AlgoStrix.FirstRecurringCharacter do
  @moduledoc """
  Find the first ocorrency of an element inside a list.
  """

  @doc """
  Return the first recurring element in a list of items.

  ## Examples:

      iex> list = [1, 2, 3, 2, 5]

      iex> AlgoStrix.FirstRecurringCharacter.check(list)
      2

      iex> list = [1, 2, 5, 5, 2, 3]

      iex> AlgoStrix.FirstRecurringCharacter.check(list)
      5
  """
  @spec first_recurring_character([term()]) :: term() | nil
  def first_recurring_character(list) do
    Enum.reduce_while(list, %{}, fn e, acc ->
      case Map.get(acc, to_string(e)) do
        nil -> {:cont, Map.put(acc, to_string(e), e)}
        e -> {:halt, e}
      end
    end)
    |> case do
      %{} -> nil
      e -> e
    end
  end
end
