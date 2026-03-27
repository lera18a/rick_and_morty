import 'package:flutter/material.dart';
import 'package:rick_and_morty/presenter/widgets/list_screen.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ListScreen());
  }
}
