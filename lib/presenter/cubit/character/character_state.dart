part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoading extends CharacterState {}

final class CharacterLoaded extends CharacterState {
  final CharacterData character;

  CharacterLoaded({required this.character});
}

final class CharacterError extends CharacterState {
  final String message;

  CharacterError({required this.message});
}
