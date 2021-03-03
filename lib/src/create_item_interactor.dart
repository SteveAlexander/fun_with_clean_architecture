import 'package:fun_with_clean_architecture/entities.dart';

class ItemCompanion {
  final String description;
  ItemCompanion(this.description);
}

abstract class ItemStore {
  Future<void> save(Item item);
}

abstract class Clock {
  DateTime now();
}

class CreateItemInteractor {
  final Clock clock;
  final ItemStore itemStore;

  CreateItemInteractor(this.itemStore, this.clock);

  Future<Item> create(ItemCompanion itemCompanion) async {
    if (itemCompanion.description.trim().isEmpty) {
      throw FormatException('The description is empty.');
    }
    final item = Item(itemCompanion.description, ctime: clock.now());
    await itemStore.save(item);
    return item;
  }
}
