import 'dijkstra.dart';

class MinHeap {
  final List<Node> _heap = [];

  void insert(Node item) {
    _heap.add(item);
    heapifyUp();
  }

  // void listNodeHeap() {
  //   for (Node node in _heap) {
  //     print(node.distance);
  //   }
  // }

  Node removeMin() {
    if (_heap.isEmpty) {
      throw Exception('A fila esta vazia');
    }
    Node minItem = _heap[0];
    _heap[0] = _heap.last;
    _heap.removeLast();
    heapifyDown();
    return minItem;
  }

  void heapifyUp() {
    int index = _heap.length - 1;
    while (index > 0 && _heap[parent(index)].distance > _heap[index].distance) {
      swap(index, parent(index));
      index = parent(index);
    }
  }

  void heapifyDown() {
    int index = 0;
    while (hasLeftChild(index)) {
      int smallerChildIndex = leftChild(index);
      if (hasRightChild(index) &&
          _heap[rightChild(index)].distance <
              _heap[leftChild(index)].distance) {
        smallerChildIndex = rightChild(index);
      }
      if (_heap[index].distance < _heap[smallerChildIndex].distance) {
        break;
      } else {
        swap(index, smallerChildIndex);
      }
      index = smallerChildIndex;
    }
  }

  void swap(int i, int j) {
    Node temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  int leftChild(int parentIndex) => 2 * parentIndex + 1;
  int rightChild(int parentIndex) => 2 * parentIndex + 2;
  int parent(int childIndex) => (childIndex - 1) ~/ 2;

  bool hasLeftChild(int index) => leftChild(index) < _heap.length;
  bool hasRightChild(int index) => rightChild(index) < _heap.length;

  bool get isNotEmpty => _heap.isNotEmpty;
}
