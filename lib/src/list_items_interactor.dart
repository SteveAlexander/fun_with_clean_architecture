import 'package:fun_with_clean_architecture/entities.dart' show Item;

abstract class ListItemsCapability {
  Future<List<Item>> allSortedChronologically();
}

class ListItemsInteractor {
  final ListItemsCapability _gateway;
  ListItemsInteractor(this._gateway);

  Future<List<Item>> listItems() async {
    return _gateway.allSortedChronologically();
  }
}
