defmodule AlgoStrix.DataStructures.Queues.QueueLinkedListNode do
  @moduledoc """
  Implementation of a Linked list node for a queue.

  %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
    value: 1,
    next: %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
      value: 20,
      next: nil
    }
  }
  """
  defstruct value: nil, next: nil

  @type t :: %__MODULE__{value: any(), next: %__MODULE__{} | nil}

  @doc """
  Creates a new Queue Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Queues.QueueLinkedListNode, as: QLLN

      iex> QLLN.new()
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{value: nil, next:  nil}
  """
  @spec new() :: t()
  def new, do: %__MODULE__{value: nil, next: nil}

  @doc """
  Creates a new Queue Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Queues.QueueLinkedListNode, as: QLLN

      iex> QLLN.new(1)
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{value: 1, next:  nil}
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{value: value, next: nil}

  @doc """
  Creates a new Queue Node.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Queues.QueueLinkedListNode, as: QLLN

      iex> QLLN.new(1, nil)
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{value: 1, next:  nil}

      iex> QLLN.new(1, QLLN.new(2))
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
        value: 1,
        next: %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
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

  Useful to add a new Node element into a Queue Linked List.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Queues.QueueLinkedListNode, as: QLLN

      iex> n1 = QLLN.new(1)
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{value: 1, next:  nil}

      iex> n2 = LinkedListNode.new(2)
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{value: 2, next:  nil}

      iex> QLLN.put_next(n1, n2)
      %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
        value: 1,
        next: %AlgoStrix.DataStructures.Queues.QueueLinkedListNode{
          value: 20,
          next: nil
        }
      }
  """
  @spec put_next(node :: t(), next :: t() | nil) :: t()
  def put_next(%__MODULE__{} = node, next), do: %__MODULE__{node | next: next}
end
