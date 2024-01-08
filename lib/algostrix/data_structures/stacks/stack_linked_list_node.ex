defmodule AlgoStrix.DataStructures.Stacks.StackLinkedListNode do
  @moduledoc """
  Node for implementing a Stack using Linked lists.

  %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
    value: 1,
    next: %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
      value: 20,
      next: nil
    }
  }
  """
  defstruct value: nil, next: nil

  @type t :: %__MODULE__{value: any(), next: %__MODULE__{} | nil}

  @doc """
  Creates a new Stack Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StackLinkedListNode, as: SLLN

      iex> SLLN.new()
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{value: nil, next:  nil}
  """
  @spec new() :: t()
  def new, do: %__MODULE__{value: nil, next: nil}

  @doc """
  Creates a new Stack Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StackLinkedListNode, as: SLLN

      iex> SLLN.new(1)
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{value: 1, next:  nil}
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{value: value, next: nil}

  @doc """
  Creates a new Stack Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StackLinkedListNode, as: SLLN

      iex> SLLN.new(1, nil)
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{value: 1, next:  nil}

      iex> SLLN.new(1, SLLN.new(2))
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
        value: 1,
        next: %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
          value: 2,
          next: nil
        }
      }
  """
  @spec new(value :: any(), next :: nil | t()) :: t()
  def new(value, nil), do: %__MODULE__{value: value, next: nil}
  def new(value, %__MODULE__{} = next), do: %__MODULE__{value: value, next: next}

  @doc """
  Put next element of node.

  Useful to add a new Node element into a Stack Linked List.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StackLinkedListNode, as: SLLN

      iex> n1 = SLLN.new(1)
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{value: 1, next:  nil}

      iex> n2 = LinkedListNode.new(2)
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{value: 2, next:  nil}

      iex> SLLN.put_next(n1, n2)
      %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
        value: 1,
        next: %AlgoStrix.DataStructures.Stacks.StackLinkedListNode{
          value: 20,
          next: nil
        }
      }
  """
  @spec put_next(node :: t(), next :: t() | nil) :: t()
  def put_next(%__MODULE__{} = node, next), do: %__MODULE__{node | next: next}
end
