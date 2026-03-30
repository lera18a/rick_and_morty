import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/core/di/injector.dart';
import 'package:rick_and_morty/data/api/character_repository_impl.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocInjector extends StatelessWidget {
  const BlocInjector({super.key, required Widget child}) : _child = child;

  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersCubit(characterRepository: getIt<CharacterRepositoryImpl>())
            ..getCharacter(),
      child: _child,
    );
  }
}
