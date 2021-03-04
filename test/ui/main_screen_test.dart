// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fun_with_clean_architecture/main.dart';
import 'package:fun_with_clean_architecture/entities.dart';

import 'package:fun_with_clean_architecture/ui/providers.dart';
import 'package:fun_with_clean_architecture/ui/todo_list.dart';

class MockUiProvider extends Mock implements UiProviders {}

void main() {
  final provider = MockUiProvider();
  when(provider).calls(#allItems).thenReturn(
    [
      Item((b) => b
        ..description = 'first item'
        ..ctime = DateTime(2020, 1, 1)),
    ],
  );
  when(provider).calls(#itemsUpdateStream).thenReturn(
        Stream.fromIterable(
          <List<Item>>[
            [
              Item((b) => b
                ..description = 'some item'
                ..ctime = DateTime(2020, 1, 1)),
            ],
          ],
        ),
      );

  testWidgets('home screen initial state', (WidgetTester tester) async {
    // Wire up back end stuff
    await tester.pumpWidget(
      ProviderScope(
        overrides: [providers.overrideWithValue(provider)],
        child: MyApp(),
      ),
    );
    expect(find.text('Todos'), findsOneWidget);
    expect(find.byType(NoDataWidget), findsOneWidget);
    await tester.pump();
    expect(find.text('some item'), findsOneWidget);

    // NEXT: refactor tests, extend tests to add an item

    // expect(find.text('Buy peanut butter'), findsOneWidget);
    // expect(find.text('Sell Ascential shares'), findsOneWidget);

    // // Verify that our counter starts at 0.
    // expect(find.text('A'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
