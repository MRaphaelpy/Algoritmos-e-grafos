// Fila do tipo generico T que recebe um item do tipo T e adiciona na fila e remove o primeiro item da fila e retorna o item removido da fila e verifica se a fila esta vazia ou nao.vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
class Fila<T> {
  final List<T> _itens = [];

  void adicionar(T item) {
    _itens.add(item);
  }

  T remover() {
    if (isEmpty) {
      throw Exception("fila vazia");
    }
    return _itens.removeAt(0);
  }

  bool get isEmpty => _itens.isEmpty;
}

// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
class Vertice {
  String cor; // (2) Cor do vertice (branco, cinza, preto)
  int distancia; // (3) Distancia a partir do vertice de origem
  Vertice? pai; // (4) Vertice predecessor na travessia BFS

  Vertice()
      : cor = 'branco', // (2) Inicializa como branco (nao visitado)
        distancia =
            double.maxFinite.toInt(), // (3) Inicializa com distancia infinita
        pai = null; // (4) Sem predecessor inicialmente
}

class Grafo {
  int vertices;
  List<List<int>> listaAdjacencia;

  Grafo(this.vertices)
      : listaAdjacencia = List.generate(vertices, (index) => []);

  void adicionarAresta(int u, int v) {
    listaAdjacencia[u].add(v);
    listaAdjacencia[v].add(u);
  }

  void bfs(int verticeOrigem) {
    List<Vertice> vertices = List.generate(this.vertices, (index) => Vertice());

    Fila<int> fila = Fila();
    vertices[verticeOrigem].cor = 'cinza'; // (5) Começa com o vertice de origem
    vertices[verticeOrigem].distancia = 0; // (6) Distancia do vertice de origem
    fila.adicionar(verticeOrigem); // (8) Enfileira o vertice de origem

    while (!fila.isEmpty) {
      // (10) Enquanto a fila nao estiver vazia
      int u = fila.remover(); // (11) Remove um vertice da fila
      print('Visitando vertice $u com distancia ${vertices[u].distancia}');

      for (int v in listaAdjacencia[u]) {
        // (12) Para cada vertice adjacente
        if (vertices[v].cor == 'branco') {
          vertices[v].cor = 'cinza'; // (13) Marca como visitado
          vertices[v].distancia =
              vertices[u].distancia + 1; // (15) Calcula a distancia
          vertices[v].pai = vertices[u]; // (16) Define o predecessor
          fila.adicionar(v); // (17) Enfileira o vertice visitado
        }
      }

      vertices[u].cor = 'preto'; // (18) Marca como completamente explorado
    }
  }
}

void main() {
  final int numVertices = 5;
  Grafo grafo = Grafo(numVertices);
  grafo.adicionarAresta(0, 1);
  grafo.adicionarAresta(0, 2);
  grafo.adicionarAresta(1, 2);
  grafo.adicionarAresta(1, 3);
  grafo.adicionarAresta(2, 3);

  print('Busca em Largura comecando do 0:');
  grafo.bfs(0);
}
