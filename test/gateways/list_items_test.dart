import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/gateways.dart'
    show InMemoryItemStore;
import 'package:fun_with_clean_architecture/interactors.dart';

void main() {
  late ListItemsCapability listGateway;
  late StoreItemCapability storageGateway;

  setUp(() {
    storageGateway = listGateway = InMemoryItemStore();
  });

  test('no preexisting todos', () {
    expect(listGateway.allSortedChronologically(), completion([]));
  });

  test('one preexisting todo item', () async {
    final description = '::irrelevant description::';
    final item = Item((b) => b
      ..description = description
      ..ctime = DateTime.utc(2021, 2, 18, 16, 45, 59));
    await storageGateway.save(item);
    expect(listGateway.allSortedChronologically(), completion([item]));
  });
}
