import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';
import 'package:rick_and_morty/presenter/cubit/liked_cubit/liked_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        return BlocBuilder<LikedCubit, LikedState>(
          builder: (context, state) {
            return Center(
              child: OutlinedButton(
                onPressed: () async {
                  context.read<LikedCubit>().cleanCache();
                  context.read<CharactersCubit>().cleanCache();
                },
                child: Text('Clean Cache'),
              ),
            );
          },
        );
      },
    );
  }
}

// 
// no internet connection -текс
// pullToRefersh 
// refreshIndicator
// переход на детаилс
// 