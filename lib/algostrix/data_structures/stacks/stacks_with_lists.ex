defmodule AlgoStrix.DataStructures.Stacks.StacksWithList do
  @moduledoc """
  Implementation of a Stack using List.

  This approach is simple and is efficient, because
  under the hood, elixir lists are linked lists.

  %AlgoStrix.DataStructures.Stacks.StacksWithLinkedList{
    items: [1, 2, 3, 4, 5]
  }

  ASCII Representation:

    +------+                  +------+
    |  12  | (top)            |  11  | (top)
    +------+           (pop)  +------+
    |  11  |           ---->   |  10  | (bottom)
    +------+                  +------+
    |  10  | (bottom)
    +------+
  """
  defstruct items: []

  @type t :: %__MODULE__{items: [any()]}

  @doc """
  Creates a new empty Stack.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StacksWithList, as: SL

      iex> SL.new()
      %AlgoStrix.DataStructures.Stacks.StacksWithList{items: []}
  """
  @spec new() :: t()
  def new, do: %__MODULE__{items: []}

  @doc """
  Creates a new Stack.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StacksWithList, as: SL

      iex> SL.new(1)
      %AlgoStrix.DataStructures.Stacks.StacksWithList{items: [1]}
  """
  @spec new(value :: any()) :: t()
  def new(value), do: %__MODULE__{items: [value]}

  @doc """
  Push a new item to Stack.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StacksWithList, as: SL

      iex> SL.new(1) |> SL.push(2)
      %AlgoStrix.DataStructures.Stacks.StacksWithList{items: [2, 1]}

      iex> SL.new(1) |> SL.push(2) |> SL.push(3)
      %AlgoStrix.DataStructures.Stacks.StacksWithList{items: [3, 2, 1]}
  """
  @spec push(stack :: t(), value :: any()) :: t()
  def push(%__MODULE__{items: items}, value), do: %__MODULE__{items: [value | items]}

  @doc """
  Remove the last inserted item of Stack.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StacksWithList, as: SL

      iex> SL.new(1) |> SL.push(2) |> SL.push(3) |> SL.pop()
      {3, %AlgoStrix.DataStructures.Stacks.StacksWithList{items: [2, 1]}

      iex> SL.new() |> SL.pop()
      {nil, %AlgoStrix.DataStructures.Stacks.StacksWithList{items: []}
  """
  @spec pop(stack :: t()) :: {nil | any(), t()}
  def pop(%__MODULE__{items: []}), do: {nil, new()}
  def pop(%__MODULE__{items: [top | rest]}), do: {top, %__MODULE__{items: rest}}

  @doc """
  Return the element at the top of the Stack.

  ## Examples:

      iex> alias AlgoStrix.DataStructures.Stacks.StacksWithList, as: SL

      iex> SL.new(1) |> SL.push(2) |> SL.push(3) |> SL.peek()
      3
  """
  @spec peek(stack :: t()) :: nil | any()
  def peek(%__MODULE__{items: []}), do: nil
  def peek(%__MODULE__{items: [top | _rest]}), do: top
end
