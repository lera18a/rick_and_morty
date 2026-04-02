import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/di/injector.dart';
import 'package:rick_and_morty/core/widgets/details_card_widget.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/presenter/cubit/character/character_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.detailEntity});

  final DetailEntity detailEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailsScreen')),
      body: BlocProvider(
        create: (context) =>
            CharacterCubit(characterRepository: getIt<RepositoryImpl>()),
        // ..getCharacterDetail(detailEntity.id),
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (BuildContext context, state) {
            return switch (state) {
              CharacterInitial() => LoadingWidget(),
              CharacterLoading() => LoadingWidget(),
              CharacterLoaded(:final detailEntity) => DetailCardWidget(
                lastLocationPlace: detailEntity.lastLocationPlace,
                firstLocationPlace: detailEntity.firstLocationPlace,
                species: detailEntity.species,
                name: detailEntity.name,
                imageURL: detailEntity.imageURL,
                character: detailEntity,
                statusLife: detailEntity.statusLife,
                likeStatus: detailEntity.likeStatus,
              ),
              CharacterError() => ErrorLoc(message: state.message),
            };
          },
        ),
      ),
    );
  }
}
