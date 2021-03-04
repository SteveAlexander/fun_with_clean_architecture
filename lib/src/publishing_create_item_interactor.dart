import 'dart:async';

import 'package:fun_with_clean_architecture/entities.dart';

import 'create_item_interactor.dart';

class PublishingCreateItemInteractor implements CreateItemInteractor {
  final CreateItemInteractor _interactor;
  final StreamController<Item> _newItemStreamController;

  PublishingCreateItemInteractor(
      this._interactor, this._newItemStreamController);

  @override
  Future<Item> create(ItemCompanion itemCompanion) async {
    final item = await _interactor.create(itemCompanion);
    _newItemStreamController.add(item);
    return item;
  }
}
