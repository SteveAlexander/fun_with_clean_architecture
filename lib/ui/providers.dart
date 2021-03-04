import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fun_with_clean_architecture/interactors.dart';
import 'package:fun_with_clean_architecture/entities.dart';

abstract class UiProviders {
  Stream<Item> get newItemStream;
  Stream<List<Item>> get itemsUpdateStream;
  CreateItemInteractor get createItemInteractor;
}

final Provider<UiProviders> providers =
    Provider<UiProviders>((_) => throw UnimplementedError());
