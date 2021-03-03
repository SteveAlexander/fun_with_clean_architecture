import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart';
import 'package:fun_with_clean_architecture/src/list_items_interactor.dart'
    show ListItemsCapability, ListItemsInteractor;

void main() {
  final gateway = ListItemsCapabilityMock();
  final interactor = ListItemsInteractor(gateway);
  final description = '::irrelevant description::';
  final instant = DateTime.utc(2021, 2, 18, 16, 45, 59);
  final item = Item((b) => b
    ..description = description
    ..ctime = instant);

  test('no preexisting items', () {
    when(gateway)
        .calls(#allSortedChronologically)
        .thenAnswer((_) => Future(() => <Item>[]));
    expect(interactor.listItems(), completion(isEmpty));
  });

  test('one item', () {
    when(gateway)
        .calls(#allSortedChronologically)
        .thenAnswer((_) => Future(() => [item]));
    expect(interactor.listItems(), completion(orderedEquals([item])));
  });

  test('two items', () async {
    final anotherItem =
        item.rebuild((b) => b..ctime = item.ctime.subtract(Duration(hours: 1)));
    final allItems = [item, anotherItem];
    when(gateway)
        .calls(#allSortedChronologically)
        .thenAnswer((_) => Future(() => allItems));
    expect(interactor.listItems(), completion(allItems));
  });
}

class ListItemsCapabilityMock extends Mock implements ListItemsCapability {}
