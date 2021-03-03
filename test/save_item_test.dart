import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;

void main() {
  test('it persists the item', () async {
    final itemStore = InMemoryItemStore();
    final description = 'Buy some peanut butter';
    final instant = DateTime.utc(2021, 2, 18, 16, 45, 59);
    final item = Item((b) => b
      ..description = description
      ..ctime = instant);

    await itemStore.save(item);

    expect(itemStore.toList(), orderedEquals([item]));
  });
}

class InMemoryItemStore {
  final _items = <Item>[];

  Future<void> save(Item item) async {
    _items.add(item);
  }

  List<Item> toList() => [..._items];
}
