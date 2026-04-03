import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/handle_exception.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final RepositoryImpl _characterRepository;

  CharacterCubit({required RepositoryImpl characterRepository})
    : _characterRepository = characterRepository,
      super(CharacterInitial());

  Future<void> getCharacterDetail(int id) async {
    emit(CharacterLoading());
    try {
      final character = await _characterRepository.getByID(id);
      if (character == null) return;
      final detail = Mapper.toDetail(character);
      emit(CharacterLoaded(detailEntity: detail));
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(CharacterError(message: errorType.message, errorType: errorType));
    }
  }

  Future<void> toggleLike(int id) async {
    final currentState = state;
    if (currentState is! CharacterLoaded) return;

    try {
      final newStatus = await _characterRepository.toggleLike(id);

      // Обновляем текущий state без запроса
      final updatedDetail = currentState.detailEntity.copyWith(
        likeStatus: newStatus,
      );

      emit(CharacterLoaded(detailEntity: updatedDetail));
    } catch (e) {
      Exception('Ошибка лайка: $e');
    }
  }
}
