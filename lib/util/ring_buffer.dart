class RingBuffer<T> {

  RingBuffer(int capacity) {
    _buffer = List<T?>.filled(capacity, null);
  }
  late final List<T?> _buffer;
  int _start = 0;
  int _size = 0;

  void addPre(T item) {
    if (_size < _buffer.length) {
      _size++;
    }
    _start = (_start - 1 + _buffer.length) % _buffer.length;
    _buffer[_start] = item;
  }

  void addBack(T item) {
    final writeIndex = (_start + _size) % _buffer.length;
    _buffer[writeIndex] = item;
    if (_size < _buffer.length) {
      _size++;
    } else {
      _start = (_start + 1) % _buffer.length;
    }
  }

  void clear() {
    _start = 0;
    _size = 0;
    _buffer.fillRange(0, _buffer.length, null);
  }

  T? operator [](int index) {
    if (index < 0 || index >= _size) return null;
    return _buffer[(_start + index) % _buffer.length];
  }

  List<T> toList() {
    final result = <T>[];
    for (var i = 0; i < _size; i++) {
      final item = this[i];
      if (item != null) {
        result.add(item);
      }
    }
    return result;
  }

  int get length => _size;

  T? get first => _size > 0 ? _buffer[_start] : null;

  T? get last =>
      _size > 0 ? _buffer[(_start + _size - 1) % _buffer.length] : null;
}
