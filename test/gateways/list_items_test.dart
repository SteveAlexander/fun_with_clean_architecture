import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/gateways.dart'
    show InMemoryItemStore;

void main() {
  test('no preexisting todos', () {
    final gateway = InMemoryItemStore();
    expect(gateway.allSortedChronologically(), completion([]));
  });

  test('one preexisting todo item', () async {
    final gateway = InMemoryItemStore();
    final description = '::irrelevant description::';
    final item = Item((b) => b
      ..description = description
      ..ctime = DateTime.utc(2021, 2, 18, 16, 45, 59));
    await gateway.save(item);
    expect(gateway.allSortedChronologically(), completion([item]));
  });
}
