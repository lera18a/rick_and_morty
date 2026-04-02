import 'package:flutter/material.dart';

class ListWidget<T> extends StatelessWidget {
  const ListWidget({super.key, required this.itemBuilder, required this.items});
  final List<T> items;
  final Widget Function(T character) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final character = items[index];
        return itemBuilder(character);
      },
    );
  }
}
