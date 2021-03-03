import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/interactors.dart'
    show StoreItemCapability;

class InMemoryItemStore implements StoreItemCapability {
  final _items = <Item>[];

  @override
  Future<void> save(Item item) async {
    _items.add(item);
  }

  List<Item> toList() => [..._items];

  Future<List<Item>> allSortedChronologically() async {
    return [];
  }
}
