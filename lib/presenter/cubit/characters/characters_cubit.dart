import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/handle_exception.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/data/models/data_models/character_data.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final RepositoryImpl _characterRepository;
  int _currentPage = 1;
  bool _hasMore = true;
  final List<CharacterData> _characters = [];
  late final StreamSubscription<int> _likeSub;

  CharactersCubit({required RepositoryImpl characterRepository})
    : _characterRepository = characterRepository,
      super(CharactersInitial()) {
    _likeSub = _characterRepository.likeUpdates.listen(_onLikeChanged);
  }

  @override
  Future<void> close() {
    _likeSub.cancel();
    return super.close();
  }

  void _onLikeChanged(int id) {
    final index = _characters.indexWhere((c) => c.id == id);
    if (index == -1) return;

    final current = _characters[index];
    _characters[index] = current.copyWith(
      likeStatus: current.likeStatus.toggle(),
    );
    _emitLoaded();
  }

  void _emitLoaded() {
    final entities = _characters.map((data) => Mapper.toList(data)).toList();
    emit(CharactersLoaded(listEntities: entities, hasMore: _hasMore));
  }

  Future<void> loadInitCharacters() async {
    emit(CharactersLoading());
    try {
      _currentPage = 1;
      _characters.clear();
      final result = await _characterRepository.getAll(_currentPage);

      _characters.addAll(result.items);
      _hasMore = result.hasMore;
      _emitLoaded();
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(CharactersError(message: errorType.message, errorType: errorType));
    }
  }

  Future<void> cleanCache() async {
    await _characterRepository.clearCache();
    await loadInitCharacters();
    await loadMoreCharacters();
  }

  Future<void> loadMoreCharacters() async {
    if (!_hasMore) return;

    try {
      _hasMore = false;
      _currentPage++;

      final characters = await _characterRepository.getAll(_currentPage);

      _characters.addAll(characters.items);
      _hasMore = characters.hasMore;

      _emitLoaded();
    } catch (e) {
      _currentPage--;
      _hasMore = true;
      final errorType = ErrorHandler.handleError(e);
      emit(CharactersError(message: errorType.message, errorType: errorType));
    }
  }

  Future<void> toggleLike(int characterId) async {
    try {
      await _characterRepository.toggleLike(characterId);
    } catch (e) {
      Exception('Ошибка лайка: $e');
    }
  }

  Future<void> refresh() async {
    await loadInitCharacters();
  }
}
