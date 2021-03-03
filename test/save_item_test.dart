import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/interface_adapters.dart'
    show InMemoryItemStore;

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
