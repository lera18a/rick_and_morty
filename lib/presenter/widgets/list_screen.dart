import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/widgets/list_card.dart';
import 'package:rick_and_morty/core/widgets/list_widget.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/core/widgets/refresh_error_loc.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/presenter/cubit/characters/characters_cubit.dart';
import 'package:rick_and_morty/presenter/widgets/details_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CharactersCubit>().loadInitCharacters();
      },
      child: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          return switch (state) {
            CharactersInitial() => const LoadingWidget(),
            CharactersLoading() => const LoadingWidget(),
            CharactersLoaded(
              :final List<ListEntity> listEntities,
              :final bool hasMore,
            ) =>
              NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      hasMore) {
                    context.read<CharactersCubit>().loadMoreCharacters();
                  }
                  return false;
                },
                child: ListWidget<ListEntity>(
                  items: listEntities,
                  itemBuilder: (listEntity) => ListCard(
                    species: listEntity.species,
                    name: listEntity.name,
                    imageURL: listEntity.imageURL,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(id: listEntity.id),
                        ),
                      );
                    },
                    statusOfCharacter: listEntity.statusOfCharacter,
                    // onPressedLike: () {
                    //   context.read<CharactersCubit>().toggleLike(listEntity.id);
                    // },
                  ),
                ),
              ),
            CharactersError(
              :final String message,
              :final ErrorType errorType,
            ) =>
              RefreshErrorLoc(
                message: message,
                errorType: errorType,
                onRefresh: () async {
                  await context.read<CharactersCubit>().loadInitCharacters();
                },
              ),
          };
        },
      ),
    );
  }
}
