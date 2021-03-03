library item;

import 'package:built_value/built_value.dart';

part 'item.g.dart';

abstract class Item implements Built<Item, ItemBuilder>  {
  DateTime get ctime;
  String get description;

  Item._();
  factory Item([void Function(ItemBuilder) updates]) = _$Item;
}
