defmodule Algostrix.DataStructures.LinkedLists.LinkedList do
  @moduledoc """
  Linked List using Nodes.

  has Head, Tail and Lenght.
  """

  alias Algostrix.DataStructures.LinkedLists.LinkedListNode
  defstruct head: nil, tail: nil, length: 0

  @type t :: %__MODULE__{
          head: LinkedListNode.t() | nil,
          tail: LinkedListNode.t() | nil,
          length: integer()
        }

  @doc """
  Create a new Linked List.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> LinkedList.new()
    %LinkedList{head: nil, tail: nil, length: 0}

    iex> LinkedList.new(1)
    %LinkedList{
      head: %LinkedListNode{value: 1, next: nil},
      tail: %LinkedListNode{value: 1, next: nil},
      length: 1
    }
  """
  @spec new() :: t()
  def new, do: %__MODULE__{head: nil, tail: nil, length: 0}

  @spec new(any()) :: t()
  def new(value) do
    node = LinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: 1}
  end

  @doc """
  Append an item at the end of a Linked List.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> l = LinkedList.new()
    %LinkedList{head: nil, tail: nil, length: 0}
    iex> LinkedList.append(l, 1)
    %LinkedList{
      head: %LinkedListNode{value: 1, next: nil},
      tail: %LinkedListNode{value: 1, next: nil},
      length: 1
    }

    iex> l = LinkedList.new(1)
    %LinkedList{
      head: %LinkedListNode{value: 1, next: nil},
      tail: %LinkedListNode{value: 1, next: nil},
      length: 1
    }
    iex> LinkedListNode.append(l, 2)
    %LinkedList{
      head: %LinkedListNode{
        value: 1,
        next: %LinkedListNode{
          value: 2,
          next: nil
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 2
    }
  """
  @spec append(t(), any()) :: t()
  def append(%__MODULE__{head: nil, tail: nil, length: length}, value) do
    node = LinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: length + 1}
  end

  def append(%__MODULE__{head: head, length: length} = list, value) do
    node = LinkedListNode.new(value)
    new_head = put_next(head, node)
    %__MODULE__{list | head: new_head, tail: node, length: length + 1}
  end

  @doc """
  Insert an item at the specified index.

  Tail is automatically updated if needed.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> l = %LinkedList{
      head: %LinkedListNode{
        value: 1,
        next: %LinkedListNode{
          value: 2,
          next: nil
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 2
    }
    iex> LinkedList.insert(l, 1, 3)
    %LinkedList{
      head: %LinkedListNode{
        value: 1,
        next: %LinkedListNode{
          value: 3,
          next: %LinkedListNode{
            value: 2,
            next: nil
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
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
  Pre append an item at the beggining of the Linked List.
  In others words, add a new item at position 0 of List.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> l = %LinkedList{
      head: %LinkedListNode{
        value: 1,
        next: %LinkedListNode{
          value: 3,
          next: %LinkedListNode{
            value: 2,
            next: nil
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 3
    }
    iex> LinkedList.prepend(0)
    %LinkedList{
      head: %LinkedListNode{
        value: 0,
        next: %LinkedListNode{
          value: 1,
          next: %LinkedListNode{
            value: 3,
            next: %LinkedListNode{
              value: 2,
              next: nil
            }
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 4
    }
  """
  @spec prepend(list :: t(), any()) :: t()
  def prepend(%__MODULE__{head: nil, tail: nil, length: length}, value) do
    node = LinkedListNode.new(value)
    %__MODULE__{head: node, tail: node, length: length + 1}
  end

  def prepend(%__MODULE__{head: head, length: length} = list, value) do
    %__MODULE__{list | head: LinkedListNode.new(value, head), length: length + 1}
  end

  @doc """
  Converts a Linked List to List.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> l = %LinkedList{
      head: %LinkedListNode{
        value: 0,
        next: %LinkedListNode{
          value: 1,
          next: %LinkedListNode{
            value: 3,
            next: %LinkedListNode{
              value: 2,
              next: nil
            }
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 4
    }
    iex> LinkedList.to_list(l)
    [0, 1, 3, 2]
  """
  @spec to_list(t()) :: [any()] | []
  def to_list(%__MODULE__{head: nil}), do: []

  def to_list(%__MODULE__{head: head}) do
    nodes_to_list(head, [])
    |> Enum.reverse()
  end

  @doc """
  Deletes an item given by it's index.

  If an index bigger than the length of the Linked List is passed,
  it will return the list without any changes.

  Tail is updated if the last item is removed.

  Ex:
    iex> alias Algostrix.DataStructures.LinkedLists.LinkedList
    iex> l = %LinkedList{
      head: %LinkedListNode{
        value: 0,
        next: %LinkedListNode{
          value: 1,
          next: %LinkedListNode{
            value: 3,
            next: %LinkedListNode{
              value: 2,
              next: nil
            }
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 4
    }
    iex> LinkedList.delete(l, 1)
    %LinkedList{
      head: %LinkedListNode{
        value: 0,
        next: %LinkedListNode{
          value: 3,
          next: %LinkedListNode{
            value: 2,
            next: nil
          }
        }
      },
      tail: %LinkedListNode{
        value: 2,
        next: nil
      },
      length: 3
    }
  """
  @spec delete(t(), integer()) :: t()
  def delete(%__MODULE__{length: length} = list, index) when index >= length, do: list

  def delete(%__MODULE__{head: head, length: length} = list, 0) do
    %__MODULE__{list | head: head.next, length: length - 1}
  end

  def delete(%__MODULE__{length: length} = list, index) do
    %__MODULE__{list | head: delete_node(list.head, index, 0), length: length - 1}
    |> find_new_tail(index)
  end

  @spec nodes_to_list(LinkedListNode.t(), [any()]) :: [any()] | []
  defp nodes_to_list(%LinkedListNode{next: nil, value: value}, acc), do: [value | acc]

  defp nodes_to_list(%LinkedListNode{value: value, next: child_node}, acc),
    do: nodes_to_list(child_node, [value | acc])

  @spec put_next(LinkedListNode.t(), LinkedListNode.t() | nil) :: LinkedListNode.t()
  defp put_next(%LinkedListNode{next: nil} = node, next), do: LinkedListNode.put_next(node, next)

  defp put_next(%LinkedListNode{next: child_node} = node, next),
    do: %{node | next: put_next(child_node, next)}

  @spec insert_node(LinkedListNode.t(), integer(), any(), integer()) :: LinkedListNode.t()
  defp insert_node(
         %LinkedListNode{next: child_node} = node,
         index_to_insert,
         value,
         current_index
       )
       when current_index < index_to_insert do
    %{node | next: insert_node(child_node, index_to_insert, value, current_index + 1)}
  end

  defp insert_node(node, index, value, index) do
    new_node = LinkedListNode.new(value, node.next)
    LinkedListNode.put_next(node, new_node)
  end

  @spec delete_node(LinkedListNode.t(), integer(), integer()) :: LinkedListNode.t()
  defp delete_node(
         %LinkedListNode{next: child_node} = node,
         index_to_delete,
         current_index
       )
       when current_index < index_to_delete do
    %{node | next: delete_node(child_node, index_to_delete, current_index + 1)}
  end

  defp delete_node(%LinkedListNode{next: next}, index_to_delete, index_to_delete), do: next

  @spec find_new_tail(t(), integer()) :: t()
  defp find_new_tail(%__MODULE__{head: head, length: length} = list, index)
       when index === length do
    tail = find_last_item(head)
    %__MODULE__{list | tail: tail}
  end

  defp find_new_tail(list, _index), do: list

  @spec find_last_item(LinkedListNode.t()) :: LinkedListNode.t()
  defp find_last_item(%LinkedListNode{next: nil} = node), do: node
  defp find_last_item(%LinkedListNode{next: node}), do: find_last_item(node)
end
