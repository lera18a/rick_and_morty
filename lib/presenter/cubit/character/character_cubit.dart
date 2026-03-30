import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/api/character_repository_impl.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepositoryImpl _characterRepository;

  CharacterCubit({required CharacterRepositoryImpl characterRepository})
    : _characterRepository = characterRepository,
      super(CharacterInitial());

  Future<void> getCharacterDetail(int id) async {
    emit(CharacterLoading());
    try {
      final character = await _characterRepository.getCharacterDetail(id);
      emit(CharacterLoaded(character: character));
    } catch (e) {
      emit(CharacterError(message: 'Ошибка: $e'));
    }
  }
}
