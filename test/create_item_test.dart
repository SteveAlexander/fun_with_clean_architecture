import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class Item {
  final String description;
  Item(this.description);
}

abstract class ItemStore {
  Future<void> save(Item item);
}

class CreateItemInteractor {
  final ItemStore itemStore;

  CreateItemInteractor(this.itemStore);

  Future<void> create(Item item) {
    if (item.description.trim().isEmpty) {
      throw FormatException('The description is empty.');
    }
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
    final interactor = CreateItemInteractor(itemStore);

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

  test('throws an exception when the description is the empty string', () {
    final itemStore = ItemStoreMock();
    when(itemStore).calls(#save).thenAnswer(doNothing);
    final interactor = CreateItemInteractor(itemStore);
    final item = Item('');
    expect(() => interactor.create(item), throwsFormatException);
  });

  test('throws an exception when the description is blank', () {
    final itemStore = ItemStoreMock();
    when(itemStore).calls(#save).thenAnswer(doNothing);
    final interactor = CreateItemInteractor(itemStore);
    final item = Item('   \t\t\t \n   ');
    expect(() => interactor.create(item), throwsFormatException);
  });
}

class ItemStoreMock extends Mock implements ItemStore {}
