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
    return [];
  }
}

void main() {
  test('no preexisting items', () {
    final itemStore = ItemStoreMock();
    when(itemStore).calls(#all).thenAnswer((_) => Future(() => <Item>[]));
    final interactor = ListItemsInteractor(itemStore);
    expect(interactor.listItems(), completion(isEmpty));
  });
}

class ItemStoreMock extends Mock implements ItemCollection {}
