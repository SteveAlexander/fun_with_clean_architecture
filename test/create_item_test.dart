import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/interactors.dart'
    show Clock, CreateItemInteractor, ItemCompanion, ItemStore;

Object? doNothing(Invocation invocation) => Future(() {});

void main() {
  final itemStore = ItemStoreMock();
  final clock = ClockMock();
  final now = DateTime.utc(2021, 2, 18, 16, 45, 59);
  final interactor = CreateItemInteractor(itemStore, clock);
  final description = 'Buy some milk';

  setUp(() {
    when(clock).calls(#now).thenReturn(DateTime.utc(2021, 2, 18, 16, 45, 59));
    when(itemStore).calls(#save).thenAnswer(doNothing);
  });

  test('it is possible to create an item with a description', () {
    Item('description', ctime: DateTime.now());
  });

  test('it persists the item', () async {
    await interactor.create(ItemCompanion(
      description,
    ));

    final callsToSave = verify(itemStore)
        .called(#save)
        .withArgs(positional: [captureAny]).captured;
    final argsToOnlyCallToSave = callsToSave.single;
    final capturedItem = argsToOnlyCallToSave.single;

    expect(capturedItem, isA<Item>());
    expect(capturedItem.description, description);
    expect(capturedItem.ctime.isAtSameMomentAs(now), isTrue);
  });

  test('it returns the created item', () {
    expect(
        interactor.create(ItemCompanion(description)),
        completion(isA<Item>()
            .having((item) => item.description, 'description', description)
            .having((item) => item.ctime.isAtSameMomentAs(now), 'created time',
                isTrue)));
  });

  test('throws an exception when the description is the empty string', () {
    expect(() => interactor.create(ItemCompanion('')), throwsFormatException);
  });

  test('throws an exception when the description is blank', () {
    expect(() => interactor.create(ItemCompanion('   \t\t\t \n   ')),
        throwsFormatException);
  });
}

class ItemStoreMock extends Mock implements ItemStore {}

class ClockMock extends Mock implements Clock {}
