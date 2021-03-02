import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class Item {
  final String description;
  Item(this.description);
}

abstract class ItemStore {
  Future<void> save(Item item);
}

class CreateItem {
  final ItemStore itemStore;

  CreateItem(this.itemStore);

  Future<void> create(Item item) {
    return itemStore.save(item);
  }
}

Object? doNothing(Invocation invocation) => Future(() {});

void main() {
  test('it is possible to create an item with a description', () {
    Item('description');
  });

  test('it persists the item', () async {
    final description = 'Buy some milk';
    final itemStore = ItemStoreMock();
    final interactor = CreateItem(itemStore);

    when(itemStore).calls(#save).thenAnswer(doNothing);

    await interactor.create(Item(description));

    final callsToSave = verify(itemStore)
        .called(#save)
        .withArgs(positional: [captureAny]).captured;
    final argsToOnlyCallToSave = callsToSave.single;
    final capturedItem = argsToOnlyCallToSave.single;

    expect(capturedItem, isA<Item>());
    expect(capturedItem.description, description);
  });
}

class ItemStoreMock extends Mock implements ItemStore {}
