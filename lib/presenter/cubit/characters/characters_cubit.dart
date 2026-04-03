import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/error_handler.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final Repository _characterRepository;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;
  final List<ListEntity> _entities = [];
  late final StreamSubscription<int> _likeSub;

  CharactersCubit({required Repository characterRepository})
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
    final index = _entities.indexWhere((c) => c.id == id);
    if (index == -1) return;

    final current = _entities[index];
    _entities[index] = current.copyWith(
      likeStatus: current.likeStatus.toggle(),
    );
    _emitLoaded();
  }

  void _emitLoaded() {
    final entities = _entities.map((data) => data).toList();
    emit(CharactersLoaded(listEntities: entities, hasMore: _hasMore));
  }

  Future<void> loadInitCharacters() async {
    emit(CharactersLoading());
    try {
      await _loadInitCharacters();
      _emitLoaded();
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(CharactersError(message: errorType.message, errorType: errorType));
    }
  }

  Future<List<ListEntity>> _loadInitCharacters() async {
    _currentPage = 1;
    _entities.clear();
    final result = await _characterRepository.getAll(_currentPage);
    final entity = result.items.map((e) => e).toList();
    _entities.addAll(entity);
    _hasMore = result.hasMore;
    return entity;
  }

  Future<void> cleanCache() async {
    await _characterRepository.clearCache();
    await loadInitCharacters();
  }

  Future<void> loadMoreCharacters() async {
    if (!_hasMore || _isLoadingMore) return;
    try {
      await _loadMoreCharacters();
      _emitLoaded();
    } catch (e) {
      _currentPage--;
      _hasMore = true;
      final errorType = ErrorHandler.handleError(e);
      emit(CharactersError(message: errorType.message, errorType: errorType));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> _loadMoreCharacters() async {
    _hasMore = false;
    _currentPage++;
    final result = await _characterRepository.getAll(_currentPage);
    final entity = result.items.map((e) => e).toList();
    _entities.addAll(entity);
    _hasMore = result.hasMore;
  }

  Future<void> refresh() async {
    await loadInitCharacters();
  }
}
