import 'filaminimaheap.dart';

class Graph {
  List<Node> vertices;

  Graph(this.vertices);
}

class Node {
  String name;
  double distance = double.infinity;
  Node? predecessor;
  List<Edge> adj;

  Node(this.name, this.adj) {
    predecessor = null;
  }

  @override
  String toString() {
    return name;
  }
}

class Edge {
  Node start;
  Node end;
  int weight;

  Edge(this.start, this.end, this.weight);
}

void initializeSingleSource(Graph G, Node s) {
  for (Node v in G.vertices) {
    v.distance = double.infinity;
    v.predecessor = null;
  }
  s.distance = 0;
}

void relax(Node u, Node v, int weight) {
  if (v.distance > u.distance + weight) {
    v.distance = u.distance + weight;
    v.predecessor = u;
  }
}

void dijkstra(Graph G, Node s) {
  initializeSingleSource(G, s);
  Set<Node> S = {};
  MinHeap Q = MinHeap();
  for (Node v in G.vertices) {
    Q.insert(v);
  }
  while (Q.isNotEmpty) {
    Node u = Q.removeMin();
    S.add(u);
    for (Edge edge in u.adj) {
      relax(u, edge.end, edge.weight);
    }
  }
}

void main() {
  Node s = Node('S', []);
  Node t = Node('T', []);
  Node x = Node('X', []);
  Node y = Node('Y', []);
  Node z = Node('Z', []);
  s.adj = [Edge(s, t, 10), Edge(s, y, 5)];

  t.adj = [Edge(t, x, 1), Edge(t, y, 2)];
  x.adj = [Edge(x, z, 4)];
  y.adj = [Edge(y, t, 3), Edge(y, x, 9), Edge(y, z, 2)];

  z.adj = [Edge(z, s, 7), Edge(z, x, 6)];

  Graph G = Graph([s, t, x, y, z]);
  dijkstra(G, s);

  print('Distâncias mínimas a partir de ${s}:');
  for (Node v in G.vertices) {
    print('Para ${v}: Distância: ${v.distance}');
  }
}
