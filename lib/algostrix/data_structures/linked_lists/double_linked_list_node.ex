defmodule AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode do
  @moduledoc """
  Double Linked List Node.

  Used to link reference to previous and next nodes.
  """
  defstruct value: nil, left: nil, right: nil

  @type t :: %__MODULE__{value: any(), left: %__MODULE__{} | nil, right: %__MODULE__{} | nil}

  @doc """
  Create a new Double Linked List Node.

  Ex:
    #### Creates an empty.
    iex> alias AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode
    iex> DoubleLinkedListNode.new()
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: nil,
      left: nil,
      right: nil
    }
  """
  @spec new(any()) :: t()
  def new(value), do: %__MODULE__{value: value, right: nil, left: nil}

  @doc """
  Create a new Double Linked List Node.

  Ex:
    #### Creates with left and right nodes, here both are nil.
    iex> DoubleLinkedListNode.new(1, nil, nil)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 1,
      left: nil,
      right: nil
    }

    #### Create two auxiliar nodes.
    iex> n1 = DoubleLinkedListNode.new(1)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 1,
      left: nil,
      right: nil
    }
    iex> n2 = DoubleLinkedListNode.new(2)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 2,
      left: nil,
      right: nil
    }

    #### Then creates a new node with reference of both n1 and n2 nodes.
    iex> DoubleLinkedListNode.new(3, n1, n2)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 3,
      left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
        value: 2,
        left: nil,
        right: nil
      },
      right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
        value: 1,
        left: nil,
        right: nil
      }
    }
  """
  @spec new(any(), t() | nil, t() | nil) :: t()
  def new(value, right, left) do
    %__MODULE__{value: value, right: right, left: left}
  end

  @doc """
  Update the left field of a DLL Node.

  Ex:
    iex> n1 = DoubleLinkedListNode.new(1)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 1,
      left: nil,
      right: nil
    }
    iex> n2 = DoubleLinkedListNode.new(2)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 2,
      left: nil,
      right: nil
    }
    iex> DoubleLinkedListNode(n2, n1)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 2,
      left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
        value: 1,
        left: nil,
        right: nil
      },
      right: nil
    }
  """
  @spec put_left(t(), t() | nil) :: t()
  def put_left(%__MODULE__{} = node, left) do
    %__MODULE__{node | left: left}
  end

  @doc """
  Update the right field of a DLL Node.

  Ex:
    iex> n1 = DoubleLinkedListNode.new(1)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 1,
      left: nil,
      right: nil
    }
    iex> n2 = DoubleLinkedListNode.new(2)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 2,
      left: nil,
      right: nil
    }
    iex> DoubleLinkedListNode(n2, n1)
    %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
      value: 2,
      left: nil,
      right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
        value: 1,
        left: nil,
        right: nil
      }
    }
  """
  @spec put_right(t(), t() | nil) :: t()
  def put_right(%__MODULE__{} = node, right) do
    %__MODULE__{node | right: right}
  end
end
