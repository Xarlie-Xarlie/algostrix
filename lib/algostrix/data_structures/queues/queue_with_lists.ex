defmodule AlgoStrix.DataStructures.Queues.QueueWithList do
  @moduledoc """
  Queue implementation using Lists.

  First In First Out.

  %AlgoStrix.DataStructures.Queues.QueueWithList{items: ["my value"]}
  """
  defstruct items: []

  @type t :: %__MODULE__{items: [any()]}

  @doc """
  Creates a new empty Queue.

  Ex:
    iex> alias AlgoStrix.DataStructures.Queues.QueueWithList, as: QL
    iex> QL.new()
    %AlgoStrix.DataStructures.Queues.QueueWithList{items: []}
  """
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Creates a new Queue with the value assigned.

  Ex:
    iex> alias AlgoStrix.DataStructures.Queues.QueueWithList, as: QL
    iex> QL.new("my value")
    %AlgoStrix.DataStructures.Queues.QueueWithList{items: ["my value"]}
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{items: [value]}

  @doc """
  Enqueue a value.

  Ex:
    iex> alias AlgoStrix.DataStructures.Queues.QueueWithList, as: QL
    iex> QL.new() |> QL.enqueue(1)
    %AlgoStrix.DataStructures.Queues.QueueWithList{items: [1]}
  """
  @spec enqueue(queue :: t(), value :: any()) :: t()
  def enqueue(%__MODULE__{items: items}, value) do
    %__MODULE__{items: [value | items]}
  end

  @doc """
  Dequeue a value.

  Ex:
    iex> alias AlgoStrix.DataStructures.Queues.QueueWithList, as: QL
    iex> QL.new() |> QL.enqueue(1) |> QL.dequeue()
    {1, %AlgoStrix.DataStructures.Queues.QueueWithList{items: []}}
  """
  @spec dequeue(queue :: t()) :: {nil | any(), t()}
  def dequeue(%__MODULE__{items: items}) do
    items
    |> List.pop_at(-1)
    |> case do
      {nil, items} -> {nil, %__MODULE__{items: items}}
      {removed, rest} -> {removed, %__MODULE__{items: rest}}
    end
  end

  @doc """
  Peek the first element of the queue.

  Ex:
    iex> alias AlgoStrix.DataStructures.Queues.QueueWithList, as: QL
    iex> QL.new() |> QL.enqueue(1) |> QL.enqueue(2) |> QL.peek()
    1
  """
  @spec peek(t()) :: nil | any()
  def peek(%__MODULE__{items: items}) do
    List.last(items)
  end
end
