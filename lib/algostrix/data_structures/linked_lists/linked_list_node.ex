defmodule Algostrix.DataStructures.LinkedLists.LinkedListNode do
  @moduledoc """
  Linked List Node.

  Contains a value and next.
  Next could be nil or a Linked List Node.
  """
  defstruct value: nil, next: nil

  @type t :: %__MODULE__{value: any(), next: nil | %__MODULE__{}}

  @doc """
  Creates a new Linked List Node.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.LinkedListNode

      iex> LinkedListNode.new(10)
      %LinkedListNode{value: 10, next: nil}

      iex> LinkedListNode.new(20, %LinkedListNode{value: 10, next: nil})
      %LinkedListNode{value: 20, next: %LinkedListNode{value: 10, next: nil}}
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{value: value, next: nil}

  @spec new(value :: any(), next :: nil | t()) :: t()
  def new(value, next), do: %__MODULE__{value: value, next: next}

  @doc """
  Put next element of node.

  Useful to add a new Linked List Node element into a Linked List.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.LinkedListNode

      iex> n1 = LinkedListNode.new(10, nil)
      %LinkedListNode{value: 10, next: nil}

      iex> n2 = LinkedListNode.new(20, nil)
      %LinkedListNode{value: 20, next: nil}

      iex> LinkedListNode.put_next(n1, n2)
      %LinkedListNode{value: 10, next: %LinkedListNode{value: 20, next: nil}}
  """
  @spec put_next(t(), next :: t() | nil) :: t()
  def put_next(%__MODULE__{} = node, next), do: %__MODULE__{node | next: next}
end
