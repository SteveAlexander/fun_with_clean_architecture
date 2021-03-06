import 'package:fun_with_clean_architecture/entities.dart';

class ItemCompanion {
  final String description;
  ItemCompanion(this.description);
}

abstract class StoreItemCapability {
  Future<void> save(Item item);
}

abstract class Clock {
  DateTime now();
}

class CreateItemInteractor {
  final Clock _clock;
  final StoreItemCapability _gateway;

  CreateItemInteractor(this._gateway, this._clock);

  Future<Item> create(ItemCompanion itemCompanion) async {
    if (itemCompanion.description.trim().isEmpty) {
      throw FormatException('The description is empty.');
    }
    final item = Item((b) => b
      ..description = itemCompanion.description
      ..ctime = _clock.now());
    await _gateway.save(item);
    return item;
  }
}
