part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoading extends CharacterState {}

final class CharacterLoaded extends CharacterState {
  final DetailEntity detailEntity;

  CharacterLoaded({required this.detailEntity});
}

final class CharacterError extends CharacterState {
  final String message;

  CharacterError({required this.message});
}
