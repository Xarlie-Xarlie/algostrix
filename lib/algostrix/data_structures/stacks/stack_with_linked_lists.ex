defmodule AlgoStrix.DataStructures.Stacks.StacksWithLikedList do
  @moduledoc """
  Implementation of a Stack using Linked Lists.

  Ex:
  %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
    top: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
      value: "asdf",
      next: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      }
    },
    bottom: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
      value: "my value",
      next: nil
    },
    length: 2
  }
  """
  defstruct top: nil, bottom: nil, length: 0

  alias AlgoStrix.DataStructures.Stacks.StackLinkedListNode, as: SLLN

  @type t :: %__MODULE__{top: nil | SLLN.t(), bottom: nil | SLLN.t(), length: integer()}

  @doc """
  Creates a new empty Stack.

  Ex:
    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new()
    %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
      top: nil,
      bottom: nil,
      length: 0
    }
  """
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Creates a new Stack.

  Ex:
    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new("my value")
    %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
      top: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      },
      bottom: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      },
      length: 1
    }
  """
  @spec new(value :: any()) :: t()
  def new(value) do
    node = SLLN.new(value)
    %__MODULE__{top: node, bottom: node, length: 1}
  end

  @doc """
  Push a new item to a Stack.

  Ex:
    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new() |> SLL.push("my value")
    %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
      top: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      },
      bottom: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      },
      length: 1
    }

    iex> SLL.new() |> SLL.push("my value") |> SLL.push("asdf")
    %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
      top: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "asdf",
        next: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
          value: "my value",
          next: nil
        }
      },
      bottom: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
        value: "my value",
        next: nil
      },
      length: 2
    }
  """
  @spec push(stack :: t(), value :: any()) :: t()
  def push(%__MODULE__{top: nil, bottom: nil, length: 0}, value) do
    new(value)
  end

  def push(%__MODULE__{top: top, length: length} = stack, value) do
    node = SLLN.new(value, top)
    %__MODULE__{stack | top: node, length: length + 1}
  end

  @doc """
  Remove the last inserted item in Stack. (LIFO)

  Ex:
    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new(1) |> SLL.push(2) |> SLL.push(3) |> SLL.pop()
    {3,
     %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
       top: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
         value: 2,
         next: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
           value: 1,
           next: nil
         }
       },
       bottom: %Algostrix.DataStructures.Stacks.StackLinkedListNode{
         value: 1,
         next: nil
       },
       length: 0
    }}

    iex> SLL.new(1) |> SLL.pop()
    {1,
     %AlgoStrix.DataStructures.Stacks.StacksWithLikedList{
       top: nil,
       bottom: nil,
       length: 0
    }}
  """
  @spec pop(stack :: t()) :: {any(), t()}
  def pop(%__MODULE__{top: nil, bottom: nil, length: 0}) do
    {nil, new()}
  end

  def pop(%__MODULE__{top: %SLLN{value: value} = top, bottom: top}) do
    {value, new()}
  end

  def pop(%__MODULE__{top: %SLLN{value: value, next: next}, length: length} = stack) do
    {value, %__MODULE__{stack | top: next, length: length - 1}}
  end

  @doc """
  Return the value at the top of the Stack.

  Ex:
    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new(1) |> SLL.push(2) |> SLL.push(3) |> SLL.peek()
    3

    iex> alias AlgoStrix.DataStructures.Stacks.StacksWithLikedList, as: SLL
    iex> SLL.new() |> SLL.peek()
    nil
  """
  @spec peek(t()) :: nil | any()
  def peek(%__MODULE__{top: nil}), do: nil
  def peek(%__MODULE__{top: %SLLN{value: value}}), do: value
end
