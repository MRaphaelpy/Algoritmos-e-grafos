class Node {
  String name;
  double distance = double.infinity;
  Node? predecessor;

  Node(this.name) {
    predecessor = null;
  }

  @override
  String toString() {
    return name;
  }
}

class Graph {
  List<Node> vertices;

  Graph(this.vertices);
}

void initializeSingleSource(Graph G, Node s) {
  // Inicializa as distâncias de todos os nós como infinito e predecessores como null
  for (Node v in G.vertices) {
    v.distance = double.infinity;
    v.predecessor = null;
  }
  // Define a distância do nó de origem como 0
  s.distance = 0;
}

void relax(Node u, Node v, int weight) {
  // Relaxa a aresta entre os nós u e v se encontrar um caminho mais curto
  if (v.distance > u.distance + weight) {
    v.distance = u.distance + weight;
    v.predecessor = u;
  }
}

class Edge {
  Node source;
  Node destination;
  int weight;

  Edge(this.source, this.destination, this.weight);
}

bool bellmanFord(Graph G, List<Edge> edges, Node s) {
  initializeSingleSource(G, s);

  // Itera V-1 vezes, onde V é o número de vértices
  for (int i = 0; i < G.vertices.length - 1; i++) {
    // Relaxa todas as arestas em cada iteração
    for (Edge edge in edges) {
      relax(edge.source, edge.destination, edge.weight);
    }
  }

  // Verifica se há ciclos negativos após as iterações
  for (Edge edge in edges) {
    if (edge.destination.distance > edge.source.distance + edge.weight) {
      return false;
    }
  }
  return true;
}

void printAtestaePai(Graph G) {
  for (Node v in G.vertices) {
    print('Vertice: $v');
    print('Distancia: ${v.distance}');
    if (v.predecessor != null) {
      print('Predecessor: ${v.predecessor}');
    }
  }
}

void main() {
  Node a = Node('a');
  Node b = Node('b');
  Node c = Node('c');
  Node d = Node('d');
  Node e = Node('e');

  List<Node> vertices = [a, b, c, d, e];

  Graph G = Graph(vertices);

  List<Edge> edges = [
    Edge(a, b, 4),
    Edge(a, d, 2),
    Edge(b, d, 3),
    Edge(d, b, 1),
    Edge(b, c, 2),
    Edge(b, e, 3),
    Edge(d, c, 4),
    Edge(d, e, 5),
    Edge(e, c, -5),
  ];

  bool result = bellmanFord(G, edges, a);

  if (result) {
    print('Nao ha ciclos negativos');
  } else {
    print('Ha ciclos negativos');
  }
  printAtestaePai(G);
}
