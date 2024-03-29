defmodule Algostrix.DataStructures.Graphs.Graph do
  @moduledoc """
  This module provides functionality for working with undirected
  graphs using an adjacency list representation.

  An adjacency list represents a graph as a co llection of lists,
  where each list contains the nodes adjacent to a particular node.
  This implementation supports adding nodes, adding connections
  between nodes, and displaying the connections of each node.
  """

  defstruct connected_nodes: %{}, number_of_nodes: 0

  @type t :: %__MODULE__{}

  @doc """
  Creates a new empty graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> Graphs.new()
      %Algostrix.DataStructures.Graphs.Graph{
        connected_nodes: %{},
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
        connected_nodes: %{"n1" => []},
        number_of_nodes: 1
      }

  """
  @spec new(term()) :: %__MODULE__{}
  def new(node), do: %__MODULE__{connected_nodes: Map.new([{node, []}]), number_of_nodes: 1}

  @doc """
  Adds a new node to the graph.

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs
      iex> graph = Graphs.new()
      iex> Graphs.add_node(graph, "n1")
      %Algostrix.DataStructures.Graphs.Graph{
        connected_nodes: %{"n1" => []},
        number_of_nodes: 1
      }

  """
  @spec add_node(%__MODULE__{}, term()) :: %__MODULE__{}
  def add_node(
        %__MODULE__{connected_nodes: connected_nodes, number_of_nodes: number_of_nodes},
        node
      ) do
    %__MODULE__{
      connected_nodes: Map.put(connected_nodes, node, []),
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
        connected_nodes: %{"n1" => ["n2"], "n2" => ["n1"]},
        number_of_nodes: 2
      }

  """
  @spec add_connection(%__MODULE__{}, term(), term()) :: %__MODULE__{}
  def add_connection(%__MODULE__{connected_nodes: connected_nodes} = graph, node_1, node_2) do
    connected_nodes
    |> Map.update(node_1, [], &[node_2 | &1])
    |> Map.update(node_2, [], &[node_1 | &1])
    |> then(&%__MODULE__{graph | connected_nodes: &1})
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
  def show_connections(%__MODULE__{connected_nodes: connected_nodes}) do
    Enum.reduce(connected_nodes, "node -> connections\n", fn {node, connection}, string_acc ->
      string_acc <> "#{node} -> [#{Enum.join(connection, ", ")}]\n"
    end)
    |> String.trim()
    |> IO.puts()
  end

  @doc """
  Performs a graph breadth first search traversal.

  Returns a map, with a level and the nodes that
  are connected to that level.

  If you have a node "n1", and use it as source.
  It could returns: %{1: ["n2", "n3"], 2: ["n4"]}
  Which means that "n2" and "n3" are directly con-
  nected to the node "n1", but "n4" is connected 
  to "n2" or "n3" not directly connected to "n1".

  ## Examples:
    
      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs

      iex> g = %Algostrix.DataStructures.Graphs.Graph{
        connected_nodes: %{
          0 => [6, 5, 4, 2, 1],
          1 => [0],
          2 => [0],
          3 => [4],
          4 => [7, 3, 0],
          5 => [0],
          6 => [0],
          7 => [8, 4],
          8 => [7, 9],
          9 => [8]
        },
        number_of_nodes: 10
      }

      iex> Graphs.breadth_first_search(g, 0)
      %{
        1 => [6, 5, 4, 2, 1],
        2 => [7, 3],
        3 => [8],
        4 => [9]
      }

      iex> Graphs.breadth_first_search(g, 4)
      %{1 => [7, 3, 0], 2 => [8, 6, 5, 2, 1], 3 => [9]}
  """
  @spec breadth_first_search(t(), term()) :: map()
  def breadth_first_search(%__MODULE__{connected_nodes: connected_nodes}, source) do
    case Map.get(connected_nodes, source) do
      nil ->
        nil

      connections ->
        bfs(connected_nodes, connections, 2, %{1 => connections}, [source])
    end
  end

  @doc """
  Performs a graph depth first search traversal.

  Returns a list of nodes that were found during
  traversal.

  It goes deep as it can in the graph.

  "Is there any path to this node?".

  ## Examples:

      iex> alias Algostrix.DataStructures.Graphs.Graph, as: Graphs

      iex> g = %Algostrix.DataStructures.Graphs.Graph{
        connected_nodes: %{
          0 => [6, 5, 4, 2, 1],
          1 => [0],
          2 => [0],
          3 => [4],
          4 => [7, 3, 0],
          5 => [0],
          6 => [0],
          7 => [8, 4],
          8 => [7, 9],
          9 => [8]
        },
        number_of_nodes: 10
      }

      iex> Graphs.depth_first_search(g, 0)
      [3, 9, 8, 7, 6, 5, 4, 2, 1]

      iex> Graphs.depth_first_search(g, 4)
      [1, 2, 5, 6, 9, 8, 7, 3, 0]
  """
  @spec depth_first_search(t(), term()) :: [dfs :: term()]
  def depth_first_search(%__MODULE__{connected_nodes: connected_nodes}, source) do
    case Map.get(connected_nodes, source) do
      nil ->
        nil

      connections ->
        dfs(connected_nodes, connections, connections, [source])
        |> elem(0)
    end
  end

  @spec dfs(map(), [term()], [term()], [term()]) :: {bfs :: [term()], visited_nodes :: [term()]}
  defp dfs(connected_nodes, dfs, nodes_to_visit, visited_nodes) do
    Enum.reject(nodes_to_visit, &(&1 in visited_nodes))
    |> Enum.reduce({dfs, visited_nodes}, fn connection, {dfs, visited_nodes} ->
      unless connection in visited_nodes do
        new_nodes_to_visit = Map.get(connected_nodes, connection)
        acc_dfs = if connection not in dfs, do: [connection | dfs], else: dfs
        acc_visited_nodes = [connection | visited_nodes]

        {new_dfs, new_visited_nodes} =
          dfs(connected_nodes, acc_dfs, new_nodes_to_visit, acc_visited_nodes)

        {new_dfs, new_visited_nodes}
      else
        {dfs, visited_nodes}
      end
    end)
  end

  @spec bfs(map(), [term()], pos_integer(), map(), [term()]) :: map()
  defp bfs(
         connected_nodes,
         connections,
         level,
         bfs,
         visited_nodes
       ) do
    {current_bfs_map, current_visited_nodes} =
      accumulate_bfs_path(connected_nodes, connections, bfs, level, visited_nodes)

    case Map.get(current_bfs_map, level) do
      [] ->
        Map.drop(current_bfs_map, [level])

      new_connections_to_search ->
        bfs(
          connected_nodes,
          new_connections_to_search,
          level + 1,
          current_bfs_map,
          current_visited_nodes
        )
    end
  end

  @spec accumulate_bfs_path(map(), [term()], map(), pos_integer(), [term()]) :: {map(), [term()]}
  defp accumulate_bfs_path(connected_nodes, connections, bfs, level, visited_nodes) do
    Enum.reject(connections, &(&1 in visited_nodes))
    |> Enum.reduce({bfs, visited_nodes}, fn connection, {bfs, visited_nodes} ->
      unless connection in visited_nodes do
        connections_to_add = new_connections_to_add(connected_nodes, connection, visited_nodes)
        acc_bfs = Map.update(bfs, level, connections_to_add, &(&1 ++ connections_to_add))
        acc_visited_nodes = [connection | visited_nodes]

        {acc_bfs, acc_visited_nodes}
      else
        {bfs, visited_nodes}
      end
    end)
  end

  @spec new_connections_to_add(map(), term(), [term()]) :: [term()]
  defp new_connections_to_add(connected_nodes, connection, visited_nodes) do
    Map.get(connected_nodes, connection)
    |> Enum.reject(&(&1 in visited_nodes))
  end
end
