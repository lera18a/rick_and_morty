import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/list_card.dart';
import 'package:rick_and_morty/core/widgets/list_widget.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/presenter/cubit/liked_cubit/liked_cubit.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCubit, LikedState>(
      builder: (context, state) {
        return switch (state) {
          LikedInitial() => const LoadingWidget(),
          LikedLoading() => const LoadingWidget(),
          LikedLoaded(
            :final List<ListEntity> listEntities,
            // :final bool hasMore,
          ) =>
            //   NotificationListener<ScrollNotification>(
            //     onNotification: (scrollInfo) {
            //       if (scrollInfo.metrics.pixels >=
            //               scrollInfo.metrics.maxScrollExtent - 200 &&
            //           hasMore) {
            //         context.read<CharactersCubit>().loadMoreCharacters();
            //       }
            //       return false;
            //     },
            // child:
            ListWidget<ListEntity>(
              items: listEntities,
              itemBuilder: (listEntity) => ListCard(
                species: listEntity.species,
                name: listEntity.name,
                imageURL: listEntity.imageURL,
                onTap: () {},
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         DetailsScreen(detailEntity: listEntity),
                //   ),
                // ),
                statusOfCharacter: listEntity.statusOfCharacter,
                likeStatus: listEntity.likeStatus,
                onPressedLike: () {
                  context.read<LikedCubit>().toggleLike(listEntity.id);
                },
              ),
            ),
          // ),
          LikedError() => ErrorLoc(message: state.message),
        };
      },
    );
  }
}
