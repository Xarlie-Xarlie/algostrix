defmodule Algostrix.HashTable do
  @moduledoc """
  Hash Tables are one of the most commom data structes.

  You use it to store a colection of data with key and values.

  It deals with hash colisions.

  Hash Table operations and complexity:
    - lookup: O(1)
    - push: O(1)
    - insert: O(1)
    - delete: O(1)
  """

  defstruct table: %{}

  def new, do: %__MODULE__{}

  def set(%__MODULE__{table: table} = hash_table, {key, value}) do
    hash = :erlang.phash2(key)

    case Map.get(table, hash) do
      nil -> [{key, value}]
      values -> [{key, value} | values]
    end
    |> then(&Map.put(table, hash, &1))
    |> then(&%{hash_table | table: &1})
  end

  def get(%__MODULE__{table: table}, key) do
    hash = :erlang.phash2(key)
    Map.get(table, hash)
  end

  def keys(%__MODULE__{} = hash_table) do
    Enum.map(hash_table.table, fn {_, values} ->
      values
    end)
    |> List.flatten()
    |> Enum.map(fn {k, _v} -> k end)
    |> Enum.uniq()
  end
end
