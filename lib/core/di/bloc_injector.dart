import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/core/di/injector.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presenter/cubit/liked_cubit/liked_cubit.dart';

class BlocInjector extends StatelessWidget {
  const BlocInjector({super.key, required Widget child}) : _child = child;

  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CharactersCubit(characterRepository: getIt<Repository>())
                ..loadInitCharacters(),
        ),
        BlocProvider(
          create: (context) =>
              LikedCubit(repository: getIt<Repository>())..load(),
        ),
        // BlocProvider(
        //   create: (context) => LikedCubit(repository: getIt<RickAndMortyApi>()),
        // ),
      ],

      child: _child,
    );
  }
}
