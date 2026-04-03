part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<ListEntity> listEntities;
  final bool hasMore;
  CharactersLoaded({required this.listEntities, required this.hasMore});
}

final class CharactersError extends CharactersState {
  final String message;
  final ErrorType errorType;
  CharactersError({required this.message, required this.errorType});
}
