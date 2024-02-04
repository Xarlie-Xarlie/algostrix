defmodule Algostrix.DataStructures.Queues.QueueWithLinkedLists do
  @moduledoc """
  Implementation of a Queue using Linked Lists.

  %Algostrix.DataStructures.Queues.QueueWithLinkedList{
    first: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
      value: "asdf",
      next: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
        value: "my value",
        next: nil
      }
    },
    last: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
      value: "my value",
      next: nil
    },
    length: 2
  }

  ## Time Complexity for Operations:
    - Enqueue (Add to the end): O(1)
    - Dequeue (Remove from the front): O(1)
    - Lenght of the queue: O(1)
    - Traverse: O(n)

  ASCII Representation:

    +------+------+------+  (dequeue)  +------+------+
    | 1234 | 5678 | 9101 |  -------->  | 5678 | 9101 |
    +------+------+------+             +------+------+
  """
  defstruct first: nil, last: nil, length: 0

  alias Algostrix.DataStructures.Queues.QueueLinkedListNode, as: QLLN

  @type t :: %__MODULE__{first: nil | QLLN.t(), last: nil | QLLN.t(), length: integer()}

  @doc """
  Creates a new empty Queue.

  ## Examples:

      iex> alias Algostrix.DataStructures.Queues.QueueWithLinkedList, as: QLL

      iex> QLL.new()
      %Algostrix.DataStructures.Queues.QueueWithLinkedList{
        first: nil,
        last: nil,
        length: 0
      }
  """
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Creates a new Queue.

  ## Examples:

      iex> alias Algostrix.DataStructures.Queues.QueueWithLinkedList, as: QLL

      iex> QLL.new("my value")
      %Algostrix.DataStructures.Queues.QueueWithLinkedList{
        first: %Algostrix.DataStructures.Queue.QueueLinkedListNode{
          value: "my value",
          next: nil
        },
        last: %Algostrix.DataStructures.Queue.QueueLinkedListNode{
          value: "my value",
          next: nil
        },
        length: 1
      }
  """
  @spec new(value :: any()) :: t()
  def new(value) do
    node = QLLN.new(value)
    %__MODULE__{first: node, last: node, length: 1}
  end

  @doc """
  Enqueue a new item to a Queue.

  ## Examples:

      iex> alias Algostrix.DataStructures.Queues.QueueWithLinkedList, as: QLL

      iex> QLL.new() |> QLL.enqueue("my value")
      %Algostrix.DataStructures.Queues.QueueWithLinkedList{
        first: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
          value: "my value",
          next: nil
        },
        last: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
          value: "my value",
          next: nil
        },
        length: 1
      }

      iex> QLL.new() |> QLL.enqueue("my value") |> QLL.enqueue("asdf")
      %Algostrix.DataStructures.Queues.QueueWithLinkedList{
        first: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
          value: "my value",
          next: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
            value: "asdf",
            next: nil
          }
        },
        last: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
          value: "asdf",
          next: nil
        },
        length: 2
      }
  """
  @spec enqueue(stack :: t(), value :: any()) :: t()
  def enqueue(%__MODULE__{first: nil, last: nil, length: 0}, value) do
    new(value)
  end

  def enqueue(%__MODULE__{first: first, length: length} = list, value) do
    node = QLLN.new(value)
    new_first = add_to_end(first, node)
    %__MODULE__{list | first: new_first, last: node, length: length + 1}
  end

  @doc """
  Remove the last inserted item in Queue. (FIFO)

  ## Examples:

      iex> alias Algostrix.DataStructures.Queues.QueueWithLinkedList, as: QLL

      iex> QLL.new(1) |> QLL.enqueue(2) |> QLL.enqueue(3) |> QLL.dequeue()
      {3,
       %Algostrix.DataStructures.Queues.QueueWithLinkedList{
         first: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
           value: 2,
           next: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
             value: 3,
             next: nil
           }
         },
         last: %Algostrix.DataStructures.Queues.QueueLinkedListNode{
           value: 3,
           next: nil
         },
         length: 0
      }}

      iex> QLL.new(1) |> QLL.dequeue()
      {1,
       %Algostrix.DataStructures.Queues.QueueWithLinkedList{
         first: nil,
         last: nil,
         length: 0
      }}
  """
  @spec dequeue(stack :: t()) :: {any(), t()}
  def dequeue(%__MODULE__{first: nil, last: nil, length: 0}) do
    {nil, new()}
  end

  def dequeue(%__MODULE__{first: %QLLN{value: value} = first, last: first}) do
    {value, new()}
  end

  def dequeue(%__MODULE__{first: %QLLN{value: value, next: next}, last: last, length: length}) do
    {value, %__MODULE__{first: next, last: last, length: length - 1}}
  end

  @doc """
  Return the value at the first of the Queue.

  ## Examples:

      iex> alias Algostrix.DataStructures.Queues.QueueWithLinkedList, as: QLL

      iex> QLL.new(1) |> QLL.enqueue(2) |> QLL.enqueue(3) |> QLL.peek()
      3

      iex> QLL.new() |> QLL.peek()
      nil
  """
  @spec peek(t()) :: nil | any()
  def peek(%__MODULE__{first: nil}), do: nil
  def peek(%__MODULE__{first: %QLLN{value: value}}), do: value

  @spec add_to_end(QLLN.t(), QLLN.t() | nil) :: QLLN.t()
  defp add_to_end(%QLLN{next: nil} = node, next), do: QLLN.put_next(node, next)

  defp add_to_end(%QLLN{next: child_node} = node, next),
    do: %{node | next: add_to_end(child_node, next)}
end
