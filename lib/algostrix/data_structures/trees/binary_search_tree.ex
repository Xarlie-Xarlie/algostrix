defmodule Algostrix.DataStructures.Trees.BinarySearchTree do
  @moduledoc """
  Binary Search Tree.

  It contains the most commom functions of a Binary Search Tree.

  %Algostrix.DataStructures.Trees.BinarySearchTree{
    root: %Algostrix.DataStructures.Trees.BinaryTreeNode{
      right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        right: nil,
        left: nil,
        value: 3
      },
      left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
        right: nil,
        left: nil,
        value: 1
      },
      value: 2
    }
  }

  Trees are special because they can perform O(log n) operations.
  It means that you do not need to traverse all nodes during
  search/insert/delete.

  For each steps you are diving the path by half of the
  possibilities. Unless you have a unbalanced tree.

  But in that cases you still have some algorithms to balance
  a binary tree.

  ASCII Representation:

        7
       / \
      5   3
     /|   |\
    6 4   2 1
  """

  alias Algostrix.DataStructures.Trees.BinaryTreeNode, as: BTN

  defstruct root: nil

  @type t :: %__MODULE__{root: nil | BTN.t()}

  @doc """
  Creates an Empty Binary Search Tree.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> BST.new()
      %Algostrix.DataStructures.Trees.BinarySearchTree{root: nil}
  """
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Creates an Binary Search Tree with a root node.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> BST.new(1)
      %Algostrix.DataStructures.Trees.BinarySearchTree{
        root: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          value: 1,
          right: nil,
          left: nil
        }
      }
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{root: BTN.new(value)}

  @doc """
  Insert a new item into the Binary Search Tree.

  It does not balance the tree. only insert the items.
  If a value already exists, it just return the already
  inserted.

  Inserts by recursive calls with tail cail optimization.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> BST.new() |> BST.insert(2) |> BST.insert(1) |> BST.insert(3)
      %Algostrix.DataStructures.Trees.BinarySearchTree{
        root: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: nil,
            left: nil,
            value: 3
          },
          left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: nil,
            left: nil,
            value: 1
          },
          value: 2
        }
      }
  """
  @spec insert(tree :: t(), value :: any()) :: t()
  def insert(%__MODULE__{root: nil}, value) do
    %__MODULE__{root: BTN.new(value)}
  end

  def insert(%__MODULE__{root: root} = tree, value) do
    %__MODULE__{tree | root: do_insert(root, value)}
  end

  @doc """
  Search a node in Binary Search Tree.

  If the value isn't contained in the tree,
  it returns nil

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> bst = BST.new() |> BST.insert(2) |> BST.insert(1) |> BST.insert(3)

      iex> BST.lookup(bst, 3)
      %Algostrix.DataStructures.Trees.BinaryTreeNode{right: nil, left: nil, value: 3}

      iex> BST.lookup(bst, 2)
      %Algostrix.DataStructures.Trees.BinaryTreeNode{
        right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          right: nil,
          left: nil,
          value: 3
        },
        left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          right: nil,
          left: nil,
          value: 1
        },
        value: 2
      }

      iex> BST.lookup(bst, 1)
      %Algostrix.DataStructures.Trees.BinaryTreeNode{right: nil, left: nil, value: 1}

      iex> BST.lookup(bst, 4)
      nil
  """
  @spec lookup(tree :: t(), value :: any()) :: nil | BTN.t()
  def lookup(%__MODULE__{root: nil}, _value), do: nil

  def lookup(%__MODULE__{root: root}, value) do
    do_lookup(root, value)
  end

  @doc """
  Remove an item from the Binary Search Tree.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 4, 12, 20], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{
        root: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: nil,
            left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
              right: nil,
              left: nil,
              value: 20
            },
            value: 28
          },
          left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
              right: nil,
              left: nil,
              value: 12
            },
            left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
              right: nil,
              left: nil,
              value: 4
            },
            value: 10
          },
          value: 17
        }
      }

      iex> tree |> BST.remove(17) |> BST.remove(28) |> BST.remove(20)
      %Algostrix.DataStructures.Trees.BinarySearchTree{
        root: %Algostrix.DataStructures.Trees.BinaryTreeNode{
          right: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: nil,
            left: nil,
            value: 12
          },
          left: %Algostrix.DataStructures.Trees.BinaryTreeNode{
            right: nil,
            left: nil,
            value: 4
          },
          value: 10
        }
      }
  """
  @spec remove(t(), value :: any()) :: t()
  def remove(%__MODULE__{root: nil}, _value), do: new()

  def remove(%__MODULE__{root: root}, value) do
    %__MODULE__{root: do_remove(root, value)}
  end

  @doc """
  Returns the Height of the tree.

  Calculates the bigger height.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 4, 12, 20], BST.new(), &BST.insert(&2, &1))

      iex> BST.height(tree)
      3

      iex> BST.new() |> BST.height()
      0
  """
  @spec height(t() | BTN.t()) :: pos_integer()
  def height(%__MODULE__{root: nil}), do: 0

  def height(%__MODULE__{root: %BTN{right: right, left: left}}) do
    1 + max(calculate_height(right), calculate_height(left))
  end

  @doc """
  Calculates the Size of a Tree.

  Each node adds one unit to size.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce(1..1000, BST.new(), &BST.insert(&2, &1))

      iex> BST.size(tree)
      1000

      iex> BST.new() |> BST.size()
      0
  """
  @spec size(tree :: t()) :: pos_integer()
  def size(%__MODULE__{root: nil}), do: 0

  def size(%__MODULE__{root: %BTN{right: right, left: left}}) do
    1 + calculate_size(right) + calculate_size(left)
  end

  @doc """
  Traverse the entire tree In Order.

  Printing every value.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.print_in_order(tree)
      1
      5
      8
      9
      10
      17
      19
      20
      28
      29
      34
      :ok
  """
  @spec print_in_order(tree :: t()) :: nil | :ok
  def print_in_order(%__MODULE__{root: nil}), do: nil

  def print_in_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    in_order(left)
    IO.puts(value)
    in_order(right)
  end

  @doc """
  Convert a Binary Search Tree into a list.

  In Order Traversal.

  The elements are added using the fast
  list insertion. Which need an Enum.reverse/1
  at the end of the function.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.to_list_in_order(tree)
      [1, 5, 8, 9, 10, 17, 19, 20, 28, 29, 34]
  """
  @spec to_list_in_order(t()) :: [any()]
  def to_list_in_order(%__MODULE__{root: nil}), do: []

  def to_list_in_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    acc_list_in_order([], left)
    |> then(&[value | &1])
    |> then(&acc_list_in_order(&1, right))
    |> Enum.reverse()
  end

  @doc """
  Traverse the entire tree In Pre Order.

  Printing every value.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.print_in_pre_order(tree)
      17
      10
      5
      1
      8
      9
      28
      20
      19
      29
      34
      :ok
  """
  @spec print_in_pre_order(tree :: t()) :: nil | :ok
  def print_in_pre_order(%__MODULE__{root: nil}), do: nil

  def print_in_pre_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    IO.puts(value)
    pre_order(left)
    pre_order(right)
  end

  @doc """
  Convert a Binary Search Tree into a list.

  Pre Order Traversal.

  The elements are added using the fast
  list insertion. Which need an Enum.reverse/1
  at the end of the function.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.to_list_pre_order(tree)
      [17, 10, 5, 1, 8, 9, 28, 20, 19, 29, 34]
  """
  @spec to_list_pre_order(t()) :: [any()]
  def to_list_pre_order(%__MODULE__{root: nil}), do: []

  def to_list_pre_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    [value]
    |> acc_list_pre_order(left)
    |> acc_list_pre_order(right)
    |> Enum.reverse()
  end

  @doc """
  Traverse the entire tree In Post Order.

  Printing every value.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.print_in_pos_order(tree)
      1
      9
      8
      5
      10
      19
      20
      34
      29
      28
      17
      :ok
  """
  @spec print_in_pos_order(tree :: t()) :: nil | :ok
  def print_in_pos_order(%__MODULE__{root: nil}), do: nil

  def print_in_pos_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    pos_order(left)
    pos_order(right)
    IO.puts(value)
  end

  @doc """
  Convert a Binary Search Tree into a list.

  Post Order traversal.

  The elements are added using the fast
  list insertion. Which need an Enum.reverse/1
  at the end of the function.

  ## Examples:

      iex> alias Algostrix.DataStructures.Trees.BinarySearchTree, as: BST

      iex> tree = Enum.reduce([17, 10, 28, 29, 20, 34, 5, 1, 8, 19, 9], BST.new(), &BST.insert(&2, &1))
      %Algostrix.DataStructures.Trees.BinarySearchTree{...}

      iex> BST.to_list_pos_order(tree)
      [1, 9, 8, 5, 10, 19, 20, 34, 29, 28, 17]
  """
  @spec to_list_pos_order(t()) :: [any()]
  def to_list_pos_order(%__MODULE__{root: nil}), do: []

  def to_list_pos_order(%__MODULE__{root: %BTN{right: right, left: left, value: value}}) do
    acc_list_pos_order([], left)
    |> acc_list_pos_order(right)
    |> then(&[value | &1])
    |> Enum.reverse()
  end

  @spec in_order(nil | BTN.t()) :: :ok
  defp in_order(nil), do: :ok

  defp in_order(%BTN{left: left, right: right, value: value}) do
    in_order(left)
    IO.puts(value)
    in_order(right)
  end

  @spec pre_order(nil | BTN.t()) :: :ok
  defp pre_order(nil), do: :ok

  defp pre_order(%BTN{left: left, right: right, value: value}) do
    IO.puts(value)
    pre_order(left)
    pre_order(right)
  end

  @spec pos_order(nil | BTN.t()) :: :ok
  defp pos_order(nil), do: :ok

  defp pos_order(%BTN{left: left, right: right, value: value}) do
    pos_order(left)
    pos_order(right)
    IO.puts(value)
  end

  @spec acc_list_in_order([any()], nil | BTN.t()) :: [any()]
  defp acc_list_in_order(acc, nil), do: acc

  defp acc_list_in_order(acc, %BTN{left: left, right: right, value: value}) do
    acc_list_in_order(acc, left)
    |> then(&[value | &1])
    |> then(&acc_list_in_order(&1, right))
  end

  @spec acc_list_pre_order([any()], nil | BTN.t()) :: [any()]
  defp acc_list_pre_order(acc, nil), do: acc

  defp acc_list_pre_order(acc, %BTN{left: left, right: right, value: value}) do
    [value | acc]
    |> acc_list_pre_order(left)
    |> acc_list_pre_order(right)
  end

  @spec acc_list_pos_order([any()], nil | BTN.t()) :: [any()]
  defp acc_list_pos_order(acc, nil), do: acc

  defp acc_list_pos_order(acc, %BTN{left: left, right: right, value: value}) do
    acc_list_pos_order(acc, left)
    |> acc_list_pos_order(right)
    |> then(&[value | &1])
  end

  @spec calculate_size(nil | BTN.t()) :: pos_integer()
  defp calculate_size(nil), do: 0
  defp calculate_size(%BTN{right: nil, left: nil}), do: 1
  defp calculate_size(%BTN{right: nil, left: left}), do: 1 + calculate_size(left)
  defp calculate_size(%BTN{right: right, left: nil}), do: 1 + calculate_size(right)

  defp calculate_size(%BTN{right: right, left: left}),
    do: 1 + calculate_size(right) + calculate_size(left)

  @spec calculate_height(nil | BTN.t()) :: pos_integer()
  defp calculate_height(nil), do: 0
  defp calculate_height(%BTN{left: nil, right: nil}), do: 1
  defp calculate_height(%BTN{left: left, right: nil}), do: 1 + calculate_height(left)
  defp calculate_height(%BTN{left: nil, right: right}), do: 1 + calculate_height(right)

  defp calculate_height(%BTN{left: left, right: right}),
    do: 1 + max(calculate_height(right), calculate_height(left))

  @spec do_remove(BTN.t(), any()) :: nil | BTN.t()
  defp do_remove(%BTN{value: value, right: nil, left: nil}, value) do
    nil
  end

  defp do_remove(%BTN{value: value, right: nil, left: %BTN{} = left}, value) do
    left
  end

  defp do_remove(%BTN{value: value, right: right, left: left}, value) do
    search_leaf_left(right)
    |> BTN.put_right(right)
    |> BTN.put_left(left)
    |> remove_moved_node()
  end

  defp do_remove(%BTN{value: current_value, right: right} = node, value)
       when current_value < value do
    %{node | right: do_remove(right, value)}
  end

  defp do_remove(%BTN{value: current_value, left: left} = node, value)
       when current_value > value do
    %{node | left: do_remove(left, value)}
  end

  @spec search_leaf_left(BTN.t()) :: BTN.t()
  defp search_leaf_left(%BTN{left: nil} = node), do: node
  defp search_leaf_left(%BTN{left: left}), do: search_leaf_left(left)

  @spec remove_moved_node(BTN.t()) :: BTN.t()
  defp remove_moved_node(%BTN{value: value, right: %BTN{value: value, right: right}} = node) do
    BTN.put_right(node, right)
  end

  defp remove_moved_node(%BTN{value: value, right: right} = node) do
    %{node | right: remove_moved_node(right, value)}
  end

  @spec remove_moved_node(BTN.t(), value :: any()) :: BTN.t()
  defp remove_moved_node(%BTN{left: %BTN{value: value, right: right}} = node, value) do
    BTN.put_left(node, right)
  end

  defp remove_moved_node(%BTN{left: %BTN{value: current_value} = left} = node, value)
       when current_value > value do
    %{node | left: remove_moved_node(left, value)}
  end

  defp remove_moved_node(%BTN{right: %BTN{value: current_value} = right} = node, value)
       when current_value < value do
    %{node | right: remove_moved_node(right, value)}
  end

  @spec do_lookup(tree_node :: BTN.t(), value :: any()) :: nil | BTN.t()
  defp do_lookup(%BTN{value: value} = node, value), do: node
  defp do_lookup(%BTN{value: current_value, left: nil}, value) when current_value > value, do: nil

  defp do_lookup(%BTN{value: current_value, right: nil}, value) when current_value < value,
    do: nil

  defp do_lookup(%BTN{value: current_value, left: left}, value) when current_value > value do
    do_lookup(left, value)
  end

  defp do_lookup(%BTN{value: current_value, right: right}, value) when current_value < value do
    do_lookup(right, value)
  end

  @spec do_insert(BTN.t(), any()) :: BTN.t()
  defp do_insert(%BTN{value: current_value, left: nil} = node, value)
       when current_value > value do
    BTN.put_left(node, BTN.new(value))
  end

  defp do_insert(%BTN{value: current_value, left: %BTN{} = left} = node, value)
       when current_value > value do
    %{node | left: do_insert(left, value)}
  end

  defp do_insert(%BTN{value: current_value, right: nil} = node, value)
       when current_value < value do
    BTN.put_right(node, BTN.new(value))
  end

  defp do_insert(%BTN{value: current_value, right: %BTN{} = right} = node, value)
       when current_value < value do
    %{node | right: do_insert(right, value)}
  end

  defp do_insert(%BTN{value: value} = node, value) do
    node
  end
end
