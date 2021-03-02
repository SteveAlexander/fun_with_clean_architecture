import 'package:test/test.dart';

class Item {
  Item(String description);
}

void main() {
  test('it is possible to create an item with a description', () {
    Item('description');
  });
}
