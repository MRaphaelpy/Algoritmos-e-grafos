class Graph {
  late Map<int, List<int>> adjacencyList;

  Graph() {
    adjacencyList = {};
  }

  void addEdge(int u, int v) {
    if (!adjacencyList.containsKey(u)) {
      adjacencyList[u] = [];
    }
    adjacencyList[u]!.add(v);
  }

  List<int> topologicalSort() {
    List<int> result = [];
    Set<int> visited = <int>{};

    void dfs(int v) {
      visited.add(v);
      if (adjacencyList.containsKey(v)) {
        for (int neighbor in adjacencyList[v]!) {
          if (!visited.contains(neighbor)) {
            dfs(neighbor);
          }
        }
      }
      result.insert(0, v); // Insere o vértice no início da lista.
    }

    for (int vertex in adjacencyList.keys) {
      if (!visited.contains(vertex)) {
        dfs(vertex);
      }
    }

    return result;
  }
}

void main() {
  Graph g = Graph();
  g.addEdge(0, 1);
  g.addEdge(0, 2);
  g.addEdge(1, 3);
  g.addEdge(2, 3);
  g.addEdge(3, 4);

  List<int> sortedVertices = g.topologicalSort();
  print("ordenacao topologica: $sortedVertices");
}
