defmodule AlgoStrix.DataStructures.LinkedLists.DoubleLinkedList do
  @moduledoc """
  Double Linked List using Nodes.

  Has Head, Tail, and Length.

  Although this module implements the most basic functions of Double Linked Lists,
  it can be challenging to use/understand in comparison to imperative languages.

  If you require a DLL implementation, consider searching for a library or using
  a GenServer to manage all nodes. With this approach, each node can have an index or
  ID in the GenServer. For Left/Right linking, you could use that index/ID,
  allowing traversal forward/backward as needed by consulting the node in the GenServer.

  One potential library can be found at: https://github.com/stocks29/dlist

  ## Time Complexity for Operations:
  - Create a new Double Linked List: O(1)
  - Append an item at the end: O(1)
  - Prepend an item at the beginning: O(1)
  - Insert an item at a specified index: O(n)
  - Delete an item at a specified index: O(n)

  head -> [value1] <-> [value2] <-> ... <-> [valueN] <- tail

  ASCII Representation:

    - (pointer, value, pointer) structure

    +-----------------+      +----------------+     +-----------------+
    | nil | 1234 | n1 | <--> | n0 | 5678 | n2 | <-> | n1 | 9101 | nil |
    +-----------------+      +----------------+     +-----------------+
  """

  alias AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode
  defstruct head: nil, tail: nil, length: 0

  @type t :: %__MODULE__{
          head: DoubleLinkedListNode.t() | nil,
          tail: DoubleLinkedListNode.t() | nil,
          length: integer()
        }

  @doc """
  Create a new Double Linked List.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.DoubleLinkedList

      iex> DoubleLinkedList.new()
      %Algostrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: nil, tail: nil, length: 0
      }
  """
  @spec new() :: t()
  def new, do: %__MODULE__{head: nil, tail: nil, length: 0}

  @doc """
  Create a new Double Linked List.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.DoubleLinkedList

      iex> DoubleLinkedList.new(1)
      %Algostrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: %DoubleLinkedListNode{value: 1, right: nil, left: nil},
        tail: %DoubleLinkedListNode{value: 1, right: nil, left: nil},
        length: 1
      }
  """
  @spec new(any()) :: t()
  def new(value) do
    node = DoubleLinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: 1}
  end

  @doc """
  Append an item at the end of a Double Linked List.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.DoubleLinkedList, as: DLL

      iex> D.new() |> D.append(1) |> D.append(2)
      %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 1,
          left: nil,
          right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 2,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 1,
              left: nil,
              right: nil
            },
            right: nil
          }
        },
        tail: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 2,
          left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 1,
            left: nil,
            right: nil
          },
          right: nil
        },
        length: 2
      }
  """
  @spec append(t(), any()) :: t()
  def append(%__MODULE__{head: nil, tail: nil, length: length}, value) do
    node = DoubleLinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: length + 1}
  end

  def append(%__MODULE__{head: head, length: 1} = list, value) do
    node = DoubleLinkedListNode.new(value, nil, head)
    new_head = put_right(head, node)
    %__MODULE__{list | head: new_head, tail: node, length: 2}
  end

  def append(%__MODULE__{head: head, length: length} = list, value) do
    node = DoubleLinkedListNode.new(value, head.left, head.right)
    new_head = put_right(head, node)
    %__MODULE__{list | head: new_head, tail: node, length: length + 1}
  end

  @doc """
  Insert an item at the specified index.

  Tail is automatically updated if needed.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.DoubleLinkedList, as: DLL

      iex> DLL.new(1) |> DLL.append(2) |> DLL.insert(1, 3)
      %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 1,
          left: nil,
          right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 3,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 1,
              left: nil,
              right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 2,
                left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                  value: 1,
                  left: nil,
                  right: nil
                },
                right: nil
              }
            },
            right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 2,
              left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 1,
                left: nil,
                right: nil
              },
              right: nil
            }
          }
        },
        tail: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 2,
          left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 1,
            left: nil,
            right: nil
          },
          right: nil
        },
        length: 3
      }
  """
  @spec insert(list :: t(), index :: integer(), value :: any()) :: t()
  def insert(list, 0, value) do
    prepend(list, value)
  end

  def insert(%__MODULE__{length: length} = list, index, value) when index >= length do
    append(list, value)
  end

  def insert(%__MODULE__{head: head, length: length} = list, index, value) do
    %__MODULE__{list | head: insert_node(head, index, value, 1), length: length + 1}
  end

  @doc """
  Pre append an item at the beggining of the Double Linked List.
  In others words, add a new item at position 0 of List.

  ## Examples:

      iex> aliasAlgostrix.DataStructures.LinkedLists.DoubleLinkedList, as: DLL

      iex> DLL.new(1) |> DLL.append(2) |> DLL.insert(1, 3) |> DLL.prepend(0)
      %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 0,
          left: nil,
          right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 1,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 0,
              left: nil,
              right: nil
            },
            right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 3,
              left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 1,
                left: nil,
                right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                  value: 2,
                  left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                    value: 1,
                    left: nil,
                    right: nil
                  },
                  right: nil
                }
              },
              right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 2,
                left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                  value: 1,
                  left: nil,
                  right: nil
                },
                right: nil
              }
            }
          }
        },
        tail: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 2,
          left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 1,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 0,
              left: nil,
              right: nil
            },
            right: nil
          },
          right: nil
        },
        length: 4
      }
  """
  @spec prepend(list :: t(), any()) :: t()
  def prepend(%__MODULE__{head: nil, tail: nil, length: length}, value) do
    node = DoubleLinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: length + 1}
  end

  def prepend(%__MODULE__{head: head, tail: tail, length: length} = list, value) do
    node = DoubleLinkedListNode.new(value)
    head = DoubleLinkedListNode.put_left(head, node)
    new_head = DoubleLinkedListNode.put_right(node, head)
    new_tail = put_left(tail, head.left)
    %__MODULE__{list | head: new_head, tail: new_tail, length: length + 1}
  end

  @doc """
  Deletes an item given by it's index.

  If an index bigger than the length of the Double Linked List is passed,
  it will return the list without any changes.

  Tail is updated if the last item is removed.

  ## Examples:

      iex> alias Algostrix.DataStructures.LinkedLists.DoubleLinkedList, as: DLL

      iex> DLL.new(1) |> DLL.append(2) |> DLL.insert(1, 3) |> DLL.prepend(0) |> DLL.delete(1)
      %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedList{
        head: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 0,
          left: nil,
          right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 3,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 1,
              left: nil,
              right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 2,
                left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                  value: 1,
                  left: nil,
                  right: nil
                },
                right: nil
              }
            },
            right: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 2,
              left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
                value: 1,
                left: nil,
                right: nil
              },
              right: nil
            }
          }
        },
        tail: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
          value: 2,
          left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
            value: 1,
            left: %AlgoStrix.DataStructures.LinkedLists.DoubleLinkedListNode{
              value: 0,
              left: nil,
              right: nil
            },
            right: nil
          },
          right: nil
        },
        length: 3
      }
  """
  @spec delete(t(), integer()) :: t()
  def delete(%__MODULE__{length: length} = list, index) when index >= length, do: list

  def delete(%__MODULE__{head: head, length: length} = list, 0) do
    %__MODULE__{list | head: head.right, length: length - 1}
  end

  def delete(%__MODULE__{length: length} = list, index) do
    %__MODULE__{list | head: delete_node(list.head, index, 0), length: length - 1}
    |> find_new_tail(index)
  end

  @spec put_right(DoubleLinkedListNode.t(), DoubleLinkedListNode.t() | nil) ::
          DoubleLinkedListNode.t()
  defp put_right(%DoubleLinkedListNode{right: nil} = node, right) do
    DoubleLinkedListNode.put_right(node, right)
  end

  defp put_right(%DoubleLinkedListNode{right: child_node} = node, right) do
    %{node | right: put_right(child_node, right)}
  end

  defp put_left(%DoubleLinkedListNode{left: nil} = node, left) do
    DoubleLinkedListNode.put_left(node, left)
  end

  defp put_left(%DoubleLinkedListNode{left: child_node} = node, left) do
    %{node | left: put_left(child_node, left)}
  end

  @spec insert_node(DoubleLinkedListNode.t(), integer(), any(), integer()) ::
          DoubleLinkedListNode.t()
  defp insert_node(
         %DoubleLinkedListNode{right: child_node} = node,
         index_to_insert,
         value,
         current_index
       )
       when current_index < index_to_insert do
    %{node | right: insert_node(child_node, index_to_insert, value, current_index + 1)}
  end

  defp insert_node(node, index, value, index) do
    new_node = DoubleLinkedListNode.new(value, node.right, node)
    DoubleLinkedListNode.put_right(node, new_node)
  end

  @spec delete_node(DoubleLinkedListNode.t(), integer(), integer()) :: DoubleLinkedListNode.t()
  defp delete_node(
         %DoubleLinkedListNode{right: child_node} = node,
         index_to_delete,
         current_index
       )
       when current_index < index_to_delete do
    %{node | right: delete_node(child_node, index_to_delete, current_index + 1)}
  end

  defp delete_node(%DoubleLinkedListNode{right: right}, index_to_delete, index_to_delete),
    do: right

  @spec find_new_tail(t(), integer()) :: t()
  defp find_new_tail(%__MODULE__{head: head, length: length} = list, index)
       when index === length do
    tail = find_last_item(head)
    %__MODULE__{list | tail: tail}
  end

  defp find_new_tail(list, _index), do: list

  @spec find_last_item(DoubleLinkedListNode.t()) :: DoubleLinkedListNode.t()
  defp find_last_item(%DoubleLinkedListNode{right: nil} = node), do: node
  defp find_last_item(%DoubleLinkedListNode{right: node}), do: find_last_item(node)
end
