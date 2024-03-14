defmodule Algostrix.DataStructures.Graphs.Graph do
  @moduledoc """
  This module provides functionality for working with undirected
  graphs using an adjacency list representation.

  An adjacency list represents a graph as a co llection of lists,
  where each list contains the nodes adjacent to a particular node.
  This implementation supports adding nodes, adding connections
  between nodes, and displaying the connections of each node.
  """

  defstruct adjacent_list: %{}, number_of_nodes: 0

  @doc """
  Creates a new empty graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> Graphs.new()
      %Algostrix.DataStructures.Graphs.Graph{
        adjacent_list: %{},
        number_of_nodes: 0
      }

  """
  @spec new() :: %__MODULE__{}
  def new, do: %__MODULE__{}

  @doc """
  Creates a new graph with a specified node.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> Graphs.new("n1")
      %Algostrix.DataStructures.Graphs.Graph{
        adjacent_list: %{"n1" => []},
        number_of_nodes: 1
      }

  """
  @spec new(term()) :: %__MODULE__{}
  def new(node), do: %__MODULE__{adjacent_list: Map.new([{node, []}]), number_of_nodes: 1}

  @doc """
  Adds a new node to the graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> graph = Graphs.new()
      iex> Graphs.add_node(graph, "n1")
      %Algostrix.DataStructures.Graphs.Graph{
        adjacent_list: %{"n1" => []},
        number_of_nodes: 1
      }

  """
  @spec add_node(%__MODULE__{}, term()) :: %__MODULE__{}
  def add_node(%__MODULE__{adjacent_list: adjacent_list, number_of_nodes: number_of_nodes}, node) do
    %__MODULE__{
      adjacent_list: Map.put(adjacent_list, node, []),
      number_of_nodes: number_of_nodes + 1
    }
  end

  @doc """
  Adds a connection between two nodes in the graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> graph = Graphs.new()
      iex> graph = Graphs.add_node(graph, "n1")
      iex> graph = Graphs.add_node(graph, "n2")
      iex> Graphs.add_connection(graph, "n1", "n2")
      %Algostrix.DataStructures.Graphs.Graph{
        adjacent_list: %{"n1" => ["n2"], "n2" => ["n1"]},
        number_of_nodes: 2
      }

  """
  @spec add_connection(%__MODULE__{}, term(), term()) :: %__MODULE__{}
  def add_connection(%__MODULE__{adjacent_list: adjacent_list} = graph, node_1, node_2) do
    adjacent_list
    |> Map.update(node_1, [], &[node_2 | &1])
    |> Map.update(node_2, [], &[node_1 | &1])
    |> then(&%__MODULE__{graph | adjacent_list: &1})
  end

  @doc """
  Displays connections of nodes in the graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> graph = Graphs.new()
      iex> graph = Graphs.add_node(graph, "n1")
      iex> graph = Graphs.add_node(graph, "n2")
      iex> graph = Graphs.add_connection(graph, "n1", "n2")
      iex> Graphs.show_connections(graph)
      node -> connections
      n1 -> [n2]
      n2 -> [n1]
      :ok

  """
  @spec show_connections(%__MODULE__{}) :: :ok
  def show_connections(%__MODULE__{adjacent_list: adjacent_list}) do
    Enum.reduce(adjacent_list, "node -> connections\n", fn {node, connection}, string_acc ->
      string_acc <> "#{node} -> [#{Enum.join(connection, ", ")}]\n"
    end)
    |> String.trim()
    |> IO.puts()
  end
end
