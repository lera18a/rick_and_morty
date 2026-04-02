import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/data/models/data_models/character_data.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final RepositoryImpl _characterRepository;
  late final StreamSubscription<int> _likeSub;
  CharacterData? _character;
  CharacterCubit({required RepositoryImpl characterRepository})
    : _characterRepository = characterRepository,
      super(CharacterInitial());

  @override
  Future<void> close() {
    _likeSub.cancel();
    return super.close();
  }

  Future<void> getCharacterDetail(int id) async {
    emit(CharacterLoading());
    try {
      final character = await _characterRepository.getByID(id);
      if (character == null) return;
      final detail = Mapper.toDetail(character);
      emit(CharacterLoaded(detailEntity: detail));
      _character = character;
      emit(CharacterLoaded(detailEntity: Mapper.toDetail(character)));
    } catch (e) {
      emit(CharacterError(message: 'Ошибка: $e'));
    }
  }

  Future<void> toggleLike() async {
    if (_character == null) return;
    try {
      await _characterRepository.toggleLike(_character!);
    } catch (e) {
      print('Ошибка лайка: $e');
    }
  }
}
