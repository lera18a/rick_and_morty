import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required RepositoryImpl repositoryImpl})
    : _repositoryImpl = repositoryImpl;
  final RepositoryImpl _repositoryImpl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          context.read<CharactersCubit>().refresh();
        },
        child: Text('data'),
      ),
    );
  }
}
