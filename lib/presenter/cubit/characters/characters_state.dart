part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<CharacterData> characters;

  CharactersLoaded({required this.characters});
}

final class CharacterDetailLoaded extends CharactersState {
  final CharacterData character;

  CharacterDetailLoaded({required this.character});
}

final class CharactersError extends CharactersState {
  final String message;

  CharactersError({required this.message});
}
