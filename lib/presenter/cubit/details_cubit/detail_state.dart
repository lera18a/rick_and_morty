part of 'detail_cubit.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final DetailEntity detailEntity;

  DetailLoaded({required this.detailEntity});
}

final class DetailError extends DetailState {
  final String message;
  final ErrorType errorType;

  DetailError({required this.message, required this.errorType});
}
