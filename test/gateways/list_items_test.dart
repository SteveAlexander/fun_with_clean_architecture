import 'package:fun_with_clean_architecture/gateways.dart'
    show InMemoryItemStore;
import 'package:test/test.dart';

void main() {
  test('no preexisting todos', () {
    final gateway = InMemoryItemStore();
    expect(gateway.allSortedChronologically(), completion([]));
  });
}
