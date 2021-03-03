import 'package:fun_with_clean_architecture/entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class ItemCollection {
  Future<List<Item>> all();
}

class ListItemsInteractor {
  final ItemCollection _itemCollection;
  ListItemsInteractor(this._itemCollection);

  Future<List<Item>> listItems() async {
    return _itemCollection.all();
  }
}

void main() {
  final itemCollection = ItemCollectionMock();
  final interactor = ListItemsInteractor(itemCollection);
  final description = '::irrelevant description::';
  final instant = DateTime.utc(2021, 2, 18, 16, 45, 59);
  final item = Item((b) => b
    ..description = description
    ..ctime = instant);

  test('no preexisting items', () {
    when(itemCollection).calls(#all).thenAnswer((_) => Future(() => <Item>[]));
    expect(interactor.listItems(), completion(isEmpty));
  });

  test('one item', () {
    when(itemCollection).calls(#all).thenAnswer((_) => Future(() => [item]));
    expect(interactor.listItems(), completion(orderedEquals([item])));
  });

  test('two items', () async {
    final anotherItem =
        item.rebuild((b) => b..ctime = item.ctime.subtract(Duration(hours: 1)));
    final allItems = [item, anotherItem];
    when(itemCollection).calls(#all).thenAnswer((_) => Future(() => allItems));
    expect(interactor.listItems(), completion(allItems));
  });
}

class ItemCollectionMock extends Mock implements ItemCollection {}
