defmodule Algostrix.Array do
  @moduledoc """
  Array is one of the most commom data structes.

  You use it to store a colection of data.

  In many languages an array has the following operations:
    - static:
      - loolup: O(1)
      - push: O(1)
      - insert: O(n)
      - delete: O(n)

    - dynamic:
      - loolup: O(1)
      - append: O(1) or O(n)
      - insert: O(n)
      - delete: O(n)

  In particular, elixir has an dynamic approach of arrays (lists).
  So append values has an O(n) time complexity, but for appending in the
  begging has an O(1) time complexity.

  Elixir already have it as an default module for lists but here is my
  implementation just for learning purposes.
  """

  defstruct length: 0, data: %{}

  @type t :: %__MODULE__{length: integer(), data: map()}

  @doc """
  Get an item from array using it's index.

  Only accepts positive indexes.

  ## Examples:

      iex> Algostrix.Array.get(%Algostrix.Array{length: 1, data: %{"0" => 0}}, 0)
      0

      iex> Algostrix.Array.get(%Algostrix.Array{length: 1, data: %{"0" => 0}}, 1)
      nil
  """
  @spec get(t(), integer()) :: any() | nil
  def get(%__MODULE__{length: length} = array, index) when index >= 0 and index < length do
    Map.get(array.data, to_string(index))
  end

  def get(%__MODULE__{}, _index), do: nil

  @doc """
  Pushes a new item on array.

  ## Examples:

      iex> Algostrix.Array.push(%Algostrix.Array{length: 0, data: %{}}, 0)
      %Algostrix.Array{length: 1, data: %{"0" => 0}}

      iex> Algostrix.Array.push(%Algostrix.Array{length: 1, data: %{"0" => 0}}, 1)
      %Algostrix.Array{length: 2, data: %{"0" => 0, "1" => 1}}
  """
  @spec push(t(), any()) :: t()
  def push(%__MODULE__{length: length, data: data} = array, item) do
    %{array | length: length + 1, data: Map.put(data, to_string(length), item)}
  end

  @doc """
  Pop the last item on array.

  ## Examples:

      iex> Algostrix.Array.pop(%Algostrix.Array{length: 0, data: %{}})
      %Algostrix.Array{length: 0, data: %{}}

      iex> Algostrix.Array.pop(%Algostrix.Array{length: 2, data: %{"0" => 0, "1" => 1}})
      %Algostrix.Array{length: 1, data: %{"0" => 0}}
  """
  @spec pop(t()) :: t()
  def pop(%__MODULE__{length: length, data: data} = array) when map_size(data) > 0 do
    new_data = Map.pop(data, to_string(length - 1))
    %{array | data: new_data, length: length - 1}
  end

  def pop(%__MODULE__{data: data} = array) when map_size(data) === 0, do: array

  @doc """
  Delete the item on array based on it's index.

  If a not valid index is passed it will return the array.
  Only accepts positive indexes.

  ## Examples:

      iex> Algostrix.Array.delete(%Algostrix.Array{length: 0, data: %{}}, 0)
      %Algostrix.Array{length: 0, data: %{}}

      iex> Algostrix.Array.delete(%Algostrix.Array{length: 2, data: %{"0" => 0, "1" => 1}}, 1)
      %Algostrix.Array{length: 1, data: %{"0" => 0}}

      iex> Algostrix.Array.delete(%Algostrix.Array{length: 2, data: %{"0" => 0, "1" => 1}}, 0)
      %Algostrix.Array{length: 1, data: %{"0" => 1}}

      iex> Algostrix.Array.delete(%Algostrix.Array{length: 1, data: %{"0" => 1}}, 0)
      %Algostrix.Array{length: 0, data: %{}}
  """
  @spec delete(t(), integer()) :: t()
  def delete(%__MODULE__{length: length, data: data} = array, index)
      when index >= 0 and index < length do
    new_data =
      Map.delete(data, to_string(index))
      |> Map.new(&shift_keys(&1, index))

    %{array | data: new_data, length: length - 1}
  end

  def delete(%__MODULE__{} = array, _index), do: array

  @spec shift_keys({binary(), any()}, integer()) :: {binary(), any()}
  defp shift_keys({key, value}, index) do
    integer_key = String.to_integer(key)

    if integer_key < index do
      {key, value}
    else
      {to_string(integer_key - 1), value}
    end
  end
end
