part of 'liked_cubit.dart';

@immutable
sealed class LikedState {}

final class LikedInitial extends LikedState {}

final class LikedLoading extends LikedState {}

final class LikedLoaded extends LikedState {
  final List<ListEntity> listEntities;

  LikedLoaded({required this.listEntities});
}

final class LikedError extends LikedState {
  final String message;

  LikedError({required this.message});
}
