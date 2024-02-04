defmodule Algostrix.DataStructures.Graphs.Graph do
  defstruct adjacent_list: %{}, number_of_nodes: 0

  def new, do: %__MODULE__{}
  def new(node), do: %__MODULE__{adjacent_list: Map.new([{node, []}]), number_of_nodes: 0}

  def add_node(%__MODULE__{adjacent_list: adjacent_list, number_of_nodes: number_of_nodes}, node) do
    %__MODULE__{
      adjacent_list: Map.put(adjacent_list, node, []),
      number_of_nodes: number_of_nodes + 1
    }
  end

  def add_connection(%__MODULE__{} = graph, node, node), do: graph

  def add_connection(%__MODULE__{adjacent_list: adjacent_list} = graph, node_1, node_2) do
    adjacent_list
    |> Map.update(node_1, [], &[node_2 | &1])
    |> Map.update(node_2, [], &[node_1 | &1])
    |> then(&%__MODULE__{graph | adjacent_list: &1})
  end

  def show_connections(%__MODULE__{adjacent_list: adjacent_list}) do
    Enum.reduce(adjacent_list, "node -> connections\n", fn {node, connection}, string_acc ->
      string_acc <> "#{node} -> #{Enum.join(connection, " ")}\n"
    end)
    |> String.trim()
  end
end
