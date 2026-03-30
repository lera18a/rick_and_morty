import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/api/character_repository_impl.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepositoryImpl _characterRepository;

  CharactersCubit({required CharacterRepositoryImpl characterRepository})
    : _characterRepository = characterRepository,
      super(CharactersInitial());

  Future<void> getCharacter() async {
    emit(CharactersLoading());
    try {
      final characters = await _characterRepository.getCharacter();
      emit(CharactersLoaded(characters: characters));
    } catch (e) {
      emit(CharactersError(message: 'Ошибка: $e'));
    }
  }

  Future<void> getCharacterDetail(int id) async {
    emit(CharactersLoading());
    try {
      final character = await _characterRepository.getCharacterDetail(id);
      emit(CharacterDetailLoaded(character: character));
    } catch (e) {
      emit(CharactersError(message: 'Ошибка: $e'));
    }
  }

  Future<void> refresh() async {
    await getCharacter();
  }
}
