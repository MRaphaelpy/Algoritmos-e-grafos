class Vertice {
  late String cor;
  late int d; // Tempo de descoberta
  late int f; // Tempo de termino
  late Vertice? pi; // Vértice pai
  late List<Vertice> adjacentes; // Lista de vertices adjacentes

  Vertice() {
    cor = 'branco';
    d = 0;
    f = 0;
    pi = null; // Inicializei o pai como null para representar senpai
    adjacentes = [];
  }
}

//####################################################
class Grafo {
  List<Vertice> vertices = [];

  void adicionarVertice() {
    vertices.add(Vertice());
  }

  void adicionarAresta(int u, int v) {
    vertices[u].adjacentes.add(vertices[v]);
    vertices[v].adjacentes.add(vertices[u]); // Para um grafo não direcionado
  }

  void buscaEmDFS() {
    int tempo = 0;

    void visitarDFS(Vertice u) {
      tempo++;
      u.d = tempo;
      u.cor = 'cinza';

      for (Vertice v in u.adjacentes) {
        if (v.cor == 'branco') {
          v.pi = u;
          visitarDFS(v);
        }
      }

      tempo++;
      u.f = tempo;
      u.cor = 'preto';
    }

    for (Vertice u in vertices) {
      if (u.cor == 'branco') {
        visitarDFS(u);
      }
    }
  }

  Grafo(int numVertices) {
    for (int i = 0; i < numVertices; i++) {
      adicionarVertice();
    }
  }
}

void main() {
  Grafo grafo = Grafo(6); // Crie um grafo com 6 vértices

  grafo.adicionarAresta(0, 1);
  grafo.adicionarAresta(0, 2);
  grafo.adicionarAresta(1, 2);
  grafo.adicionarAresta(1, 3);
  grafo.adicionarAresta(2, 3);
  grafo.adicionarAresta(4, 5);

  print('Executando DFS no grafo:');
  grafo.buscaEmDFS();

  for (int i = 0; i < grafo.vertices.length; i++) {
    print(
        'Vertice $i - cor: ${grafo.vertices[i].cor}, pai: ${grafo.vertices[i].pi?.d}, '
        'Tempo de descoberta: ${grafo.vertices[i].d}, Tempo: ${grafo.vertices[i].f}');
  }
}
