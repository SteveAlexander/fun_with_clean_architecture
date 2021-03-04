// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fun_with_clean_architecture/main.dart';
import 'package:fun_with_clean_architecture/entities.dart';

import 'package:fun_with_clean_architecture/ui/providers.dart';
import 'package:fun_with_clean_architecture/ui/todo_list.dart';

class MockUiProviders extends Mock implements UiProviders {}

extension SetUpProviderScope on WidgetTester {
  Future<void> pumpWithScope(Widget widget, UiProviders provider) {
    return pumpWidget(
      ProviderScope(
        overrides: [providers.overrideWithValue(provider)],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      ),
    );
  }
}

Stream<List<Item>> emptyItemStream() => Stream.fromIterable([]);

void main() {
  testWidgets('home screen has correct title', (WidgetTester tester) async {
    final provider = MockUiProviders();
    when(provider).calls(#itemsUpdateStream).thenReturn(emptyItemStream());
    await tester.pumpWithScope(MyApp(), provider);
    expect(find.text('Todos'), findsOneWidget);
  });

  testWidgets('Before showing the list of items, show nothing',
      (WidgetTester tester) async {
    final provider = MockUiProviders();
    when(provider).calls(#itemsUpdateStream).thenReturn(emptyItemStream());
    await tester.pumpWithScope(TodoList(), provider);
    expect(find.byType(NoDataWidget), findsOneWidget);
  });
  testWidgets('There are no items, so show that there are no items',
      (WidgetTester tester) async {
    final provider = MockUiProviders();
    when(provider).calls(#itemsUpdateStream).thenReturn(emptyItemStream());
    await tester.pumpWithScope(TodoList(), provider);
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
  });
  testWidgets('There is just one item', (WidgetTester tester) async {
    final provider = MockUiProviders();
    when(provider).calls(#itemsUpdateStream).thenReturn(Stream.fromIterable([
          [
            Item((b) => b
              ..description = 'some item'
              ..ctime = DateTime(2020, 1, 1)),
          ],
        ]));
    await tester.pumpWithScope(TodoList(), provider);
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsOneWidget);
    expect(find.widgetWithText(Card, 'some item'), findsOneWidget);
  });
  testWidgets('There are two items', (WidgetTester tester) async {
    final provider = MockUiProviders();
    when(provider).calls(#itemsUpdateStream).thenReturn(Stream.fromIterable([
          [
            Item((b) => b
              ..description = 'first item'
              ..ctime = DateTime(2020, 1, 1)),
            Item((b) => b
              ..description = 'second item'
              ..ctime = DateTime(2020, 1, 1)),
          ],
        ]));
    await tester.pumpWithScope(TodoList(), provider);
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));
    expect(
      tester.getTopLeft(find.widgetWithText(Card, 'first item')).dy,
      lessThan(
        tester.getTopLeft(find.widgetWithText(Card, 'second item')).dy,
      ),
    );
  });
}
