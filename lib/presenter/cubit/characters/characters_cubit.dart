import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
      print('1. Начинаю загрузку'); // добавь
      final result = await _characterRepository.getAll(_currentPage);

      print('2. Получил данные: ${result.items.length} шт'); // добавь
      // final entities = result.items.map((data) => Mapper.toList(data)).toList();

      // print('3. Замапил в entities: ${entities.length} шт'); // добавь
      _characters.addAll(result.items);
      _hasMore = result.hasMore;
      _emitLoaded();
    } catch (e) {
      print('ОШИБКА: $e'); // добавь
      emit(CharactersError(message: 'Ошибка: $e'));
    }
  }

  Future<void> loadMoreCharacters() async {
    if (!_hasMore) return;

    try {
      _hasMore = false;
      _currentPage++;

      final characters = await _characterRepository.getAll(_currentPage);
      // final entities = characters.items
      //     .map((data) => Mapper.toList(data))
      //     .toList();

      _characters.addAll(characters.items);
      _hasMore = characters.hasMore;

      _emitLoaded();
    } catch (e) {
      _currentPage--;
      _hasMore = true;
      emit(CharactersError(message: 'Ошибка: $e'));
    }
  }

  Future<void> toggleLike(int characterId) async {
    final index = _characters.indexWhere((c) => c.id == characterId);
    if (index == -1) return;

    final character = _characters[index];

    try {
      // Вызываем репозиторий — он вернёт новый статус
      final newStatus = await _characterRepository.toggleLike(character);

      // Обновляем локальный список
      // _characters[index] = character.copyWith(likeStatus: newStatus);

      _emitLoaded();
    } catch (e) {
      print('Ошибка лайка: $e');
    }
  }

  Future<void> refresh() async {
    await loadInitCharacters();
  }
}
