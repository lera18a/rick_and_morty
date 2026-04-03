import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/error_handler.dart';
import 'package:rick_and_morty/domain/models/like_status.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';
import 'package:rick_and_morty/domain/use_cases/like_character_use_case.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final Repository _characterRepository;

  DetailCubit({required Repository characterRepository})
    : _characterRepository = characterRepository,

      super(DetailInitial());

  Future<void> getCharacterDetail(int id) async {
    emit(DetailLoading());
    try {
      final detail = await _characterRepository.getByID(id);
      if (detail == null) {
        emit(
          DetailError(
            message: 'Персонаж не найден',
            errorType: ErrorType.unknown,
          ),
        );
        return;
      }
      emit(DetailLoaded(detailEntity: detail));
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(DetailError(message: errorType.message, errorType: errorType));
    }
  }

  Future<void> toggleLike(int id, LikeStatus likeStatus) async {
    final currentState = state;
    if (currentState is! DetailLoaded) return;
    try {
      final toggle = await LikeCharacterUseCase(
        repository: _characterRepository,
      ).execuit(id, likeStatus);
      final updatedDetail = currentState.detailEntity.copyWith(
        likeStatus: toggle,
      );
      emit(DetailLoaded(detailEntity: updatedDetail));
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(DetailError(message: errorType.message, errorType: errorType));
    }
  }
}
