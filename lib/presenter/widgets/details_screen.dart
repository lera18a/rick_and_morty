import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/di/injector.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/widgets/details_card_widget.dart';
import 'package:rick_and_morty/core/widgets/error_loc.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';
import 'package:rick_and_morty/presenter/cubit/details_cubit/detail_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.id});

  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailsScreen')),
      body: BlocProvider(
        create: (context) =>
            DetailCubit(characterRepository: getIt<Repository>())
              ..getCharacterDetail(id),
        child: BlocBuilder<DetailCubit, DetailState>(
          builder: (BuildContext context, state) {
            return switch (state) {
              DetailInitial() => LoadingWidget(),
              DetailLoading() => LoadingWidget(),
              DetailLoaded(:final detailEntity) => DetailCardWidget(
                lastLocationPlace: detailEntity.lastLocationPlace,
                firstLocationPlace: detailEntity.firstLocationPlace,
                species: detailEntity.species,
                name: detailEntity.name,
                imageURL: detailEntity.imageURL,
                character: detailEntity,
                statusLife: detailEntity.statusLife,
                likeStatus: detailEntity.likeStatus,
                onPressedLike: () async {
                  await context.read<DetailCubit>().toggleLike(
                    id,
                    detailEntity.likeStatus,
                  );
                },
              ),
              DetailError(:final String message, :final ErrorType errorType) =>
                ErrorLoc(message: message, errorType: errorType),
            };
          },
        ),
      ),
    );
  }
}
