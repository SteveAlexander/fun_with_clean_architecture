import 'package:fun_with_clean_architecture/entities.dart' show Item;
import 'package:fun_with_clean_architecture/interactors.dart'
    show ListItemsCapability, StoreItemCapability;

class InMemoryItemStore implements StoreItemCapability, ListItemsCapability {
  final _items = <Item>[];

  @override
  Future<void> save(Item item) async {
    _items.add(item);
  }

  List<Item> toList() => [..._items];

  @override
  Future<List<Item>> allSortedChronologically() async {
    return toList()..sort((a, b) => a.ctime.compareTo(b.ctime));
  }
}
