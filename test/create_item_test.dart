import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/interactors.dart'
    show Clock, CreateItemInteractor, ItemCompanion, StoreItemCapability;

Object? doNothing(Invocation invocation) => Future(() {});

void main() {
  final itemStore = ItemStoreMock();
  final clock = ClockMock();
  final instant = DateTime.utc(2021, 2, 18, 16, 45, 59);
  final interactor = CreateItemInteractor(itemStore, clock);
  final description = 'Buy some milk';
  final item = Item((b) => b
    ..description = description
    ..ctime = instant);

  setUp(() {
    when(clock).calls(#now).thenReturn(DateTime.utc(2021, 2, 18, 16, 45, 59));
    when(itemStore).calls(#save).thenAnswer(doNothing);
  });

  test('it is possible to create an item with a description', () {
    Item((b) => b
      ..description = 'description'
      ..ctime = DateTime.now());
  });

  test('it persists the item', () async {
    await interactor.create(ItemCompanion(description));

    final callsToSave = verify(itemStore)
        .called(#save)
        .withArgs(positional: [captureAny]).captured;
    final argsToOnlyCallToSave = callsToSave.single;
    final capturedItem = argsToOnlyCallToSave.single;

    expect(capturedItem, item);
  });

  test('it returns the created item', () {
    expect(interactor.create(ItemCompanion(description)), completion(item));
  });

  test('throws an exception when the description is the empty string', () {
    expect(() => interactor.create(ItemCompanion('')), throwsFormatException);
  });

  test('throws an exception when the description is blank', () {
    expect(() => interactor.create(ItemCompanion('   \t\t\t \n   ')),
        throwsFormatException);
  });
}

class ItemStoreMock extends Mock implements StoreItemCapability {}

class ClockMock extends Mock implements Clock {}
