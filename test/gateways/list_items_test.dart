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
    final item = Item((b) => b
      ..description = '::irrelevant description::'
      ..ctime = DateTime.utc(2021, 2, 18, 16, 45, 59));
    await storageGateway.save(item);
    expect(listGateway.allSortedChronologically(), completion([item]));
  });

  test('with 2 items, they are returned in chronological order', () async {
    final oldItem = Item((b) => b
      ..description = '::irrelevant description::'
      ..ctime = DateTime.utc(2021, 2, 18, 16, 45, 59));
    final recentItem =
        oldItem.rebuild((b) => b..ctime = oldItem.ctime.add(Duration(days: 1)));
    await storageGateway.save(recentItem);
    await storageGateway.save(oldItem);
    expect(listGateway.allSortedChronologically(),
        completion([oldItem, recentItem]));
  });
}
