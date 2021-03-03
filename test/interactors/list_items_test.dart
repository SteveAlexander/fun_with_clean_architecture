import 'package:fun_with_clean_architecture/entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class ListItemsCapability {
  Future<List<Item>> allSortedChronologically();
}

class ListItemsInteractor {
  final ListItemsCapability _gateway;
  ListItemsInteractor(this._gateway);

  Future<List<Item>> listItems() async {
    return _gateway.allSortedChronologically();
  }
}

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
