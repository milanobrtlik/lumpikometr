import 'dart:math';

abstract class Entity {
  final int id;

  Entity({required this.id});
}

abstract class Repository<T extends Entity> {
  final List<T> _items;

  Repository(this._items);

  Future<List<T>> getAll() async {
    await dummyDelay();
    return _items;
  }

  Future<T> get(int id) async {
    await dummyDelay();
    return _items.firstWhere((test) => test.id == id);
  }

  Future<void> add(T lumpik) async {
    await dummyDelay();
    _items.add(lumpik);
  }

  Future<void> remove(T item) async {
    await dummyDelay();
    _items.removeWhere((test) => test.id == test.id);
  }

  Future<void> dummyDelay({int offset = 150, int randomness = 200}) async {
    await Future.delayed(Duration(milliseconds: offset + Random().nextInt(randomness)));
  }
}