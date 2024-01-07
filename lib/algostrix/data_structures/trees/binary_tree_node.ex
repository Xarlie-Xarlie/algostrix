defmodule Algostrix.DataStructures.Trees.BinaryTreeNode do
  @moduledoc """
  Binary Tree Node to built a new Tree.

  %Algostrix.DataStructures.Trees.BinaryTreeNode{
    right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 2
    },
    left: nil,
    value: 1
  }
  """

  defstruct right: nil, left: nil, value: nil

  @type t :: %__MODULE__{value: any(), left: nil | %__MODULE__{}, right: nil | %__MODULE__{}}

  @doc """
  Create a empty binary tree node.

  Ex:
  iex> alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN
  iex> BTN.new()
  %Algostrix.DataStructures.Trees.BinaryTreeNode{
    left: nil,
    right: nil,
    value: nil
  }
  """
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Create a new binary tree node with a value assiged.

  Ex:
  iex> alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN
  iex> BTN.new(1)
  %Algostrix.DataStructures.Trees.BinaryTreeNode{
    left: nil,
    right: nil,
    value: 1
  }
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @doc """
  Create a new binary tree node with a value and left/right nodes.

  Ex:
    iex> alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN
    iex> n1 = BTN.new(1)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 1
    }
    iex> n2 = BTN.new(2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 2
    }
    iex> BTN.new(3, n1, n2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        left: nil,
        right: nil,
        value: 1
      },
      right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        left: nil,
        right: nil,
        value: 2
      },
      value: 3
    }
  """
  @spec new(value :: any(), left :: nil | t(), right :: nil | t()) :: t()
  def new(value, left, right), do: %__MODULE__{left: left, right: right, value: value}

  @doc """
  Put an new node or nil as the right pointer.

  Ex:
    iex> alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN
    iex> n1 = BTN.new(1)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 1
    }
    iex> n2 = BTN.new(2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 2
    }
    iex> BTN.put_right(n1, n2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        left: nil,
        right: nil,
        value: 2
      },
      left: nil,
      value: 1
    }
  """
  @spec put_right(node :: t(), right :: nil | t()) :: t()
  def put_right(%__MODULE__{} = node, right) do
    %__MODULE__{node | right: right}
  end

  @doc """
  Put an new node or nil as the left pointer.

  Ex:
    iex> alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN
    iex> n1 = BTN.new(1)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 1
    }
    iex> n2 = BTN.new(2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      left: nil,
      right: nil,
      value: 2
    }
    iex> BTN.put_left(n1, n2)
    %Algostrix.DataStructures.Trees.BinaryTreeNode{
      right: nil,
      left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        left: nil,
        right: nil,
        value: 2
      },
      value: 1
    }
  """
  @spec put_left(node :: t(), left :: nil | t()) :: t()
  def put_left(%__MODULE__{} = node, left) do
    %__MODULE__{node | left: left}
  end
end
