import 'package:fun_with_clean_architecture/entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class ItemCollection {
  Future<List<Item>> all();
}

class ListItemsInteractor {
  // ignore: unused_field
  final ItemCollection _itemCollection;
  ListItemsInteractor(this._itemCollection);

  Future<List<Item>> listItems() async {
    return _itemCollection.all();
  }
}

void main() {
  test('no preexisting items', () {
    final itemStore = ItemStoreMock();
    when(itemStore).calls(#all).thenAnswer((_) => Future(() => <Item>[]));
    final interactor = ListItemsInteractor(itemStore);
    expect(interactor.listItems(), completion(isEmpty));
  });

  test('one item', () {
    final description = '::irrelevant description::';
    final instant = DateTime.utc(2021, 2, 18, 16, 45, 59);
    final itemCollection = ItemStoreMock();
    final item = Item(description, ctime: instant);
    when(itemCollection).calls(#all).thenAnswer((_) => Future(() => [item]));
    final interactor = ListItemsInteractor(itemCollection);
    expect(
        interactor.listItems(),
        completion(allOf(
            hasLength(1),
            contains(isA<Item>()
                .having((item) => item.description, 'description', description)
                .having((item) => item.ctime.isAtSameMomentAs(instant), 'ctime',
                    isTrue)))));
  });
}

class ItemStoreMock extends Mock implements ItemCollection {}
