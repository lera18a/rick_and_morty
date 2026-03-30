import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/widgets/details_card_widget.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';
import 'package:rick_and_morty/presenter/cubit/character/character_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.character});

  final CharacterData character;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailsScreen')),
      body: BlocProvider(
        create: (context) =>
            CharacterCubit(characterRepository: context.read())
              ..getCharacterDetail(character.id),
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (BuildContext context, state) {
            return switch (state) {
              CharacterInitial() => LoadingWidget(),
              CharacterLoading() => LoadingWidget(),
              CharacterLoaded() => Expanded(
                child: DetailCardWidget(
                  lastLocationPlace: character.locationName,
                  firstLocationPlace: character.originName,
                  status: character.status,
                  species: character.species,
                  name: character.name,
                  imageURL: character.image,
                  character: character,
                ),
              ),
              CharacterError() => ErrorLoc(message: state.message),
            };
          },
        ),
      ),
    );
  }
}
