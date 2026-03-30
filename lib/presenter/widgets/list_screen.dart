import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/list_cards_widget.dart';
import 'package:rick_and_morty/core/widgets/list_widget.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';
import 'package:rick_and_morty/presenter/widgets/details_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          return switch (state) {
            CharactersInitial() => const LoadingWidget(),
            CharactersLoading() => const LoadingWidget(),
            CharactersLoaded(:final List<CharacterData> characters) =>
              ListWidget<CharacterData>(
                itemBuilder: (character) => ListCardsWidget(
                  lastLocationPlace: character.locationName,
                  firstLocationPlace: character.originName,
                  status: character.status,
                  species: character.species,
                  name: character.name,
                  imageURL: character.image,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsScreen()),
                  ),
                ),
                characters: characters,
              ),
            CharacterDetailLoaded() => Placeholder(),
            CharactersError() => ErrorLoc(message: state.message),
          };
        },
      ),
    );
  }
}
