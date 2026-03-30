import 'package:flutter/material.dart';

class ListWidget<T> extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.itemBuilder,
    required this.characters,
  });
  final List<T> characters;
  final Widget Function(T character) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return itemBuilder(character);
      },
    );
  }
}
