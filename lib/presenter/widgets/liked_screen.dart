import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/list_card.dart';
import 'package:rick_and_morty/core/widgets/list_widget.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/presenter/cubit/liked_cubit/liked_cubit.dart';
import 'package:rick_and_morty/presenter/widgets/details_screen.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCubit, LikedState>(
      builder: (context, state) {
        return switch (state) {
          LikedInitial() => const LoadingWidget(),
          LikedLoading() => const LoadingWidget(),
          LikedLoaded(:final List<ListEntity> listEntities) =>
            ListWidget<ListEntity>(
              items: listEntities,
              itemBuilder: (listEntity) => ListCard(
                species: listEntity.species,
                name: listEntity.name,
                imageURL: listEntity.imageURL,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(id: listEntity.id),
                  ),
                ),
                statusOfCharacter: listEntity.statusOfCharacter,
                // onPressedLike: () {
                //   context.read<LikedCubit>().toggleLike(listEntity.id);
                // },
              ),
            ),
          // ),
          LikedError(:final String message, :final ErrorType errorType) =>
            ErrorLoc(message: message, errorType: errorType),
        };
      },
    );
  }
}
