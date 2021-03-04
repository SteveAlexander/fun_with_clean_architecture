import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fun_with_clean_architecture/entities.dart';

import 'providers.dart';

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final p = watch(providers);
    return StreamBuilder<List<Item>>(
      stream: p.itemsUpdateStream,
      builder: (context, snapshot) {
        final items = snapshot.data;
        if (items == null) {
          return NoDataWidget();
        }
        return TodoColumn(items);
      },
    );
  }
}

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TodoColumn extends StatelessWidget {
  final List<Item> items;
  TodoColumn(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (final item in items) ItemCard(item)],
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(item.description),
    );
  }
}
