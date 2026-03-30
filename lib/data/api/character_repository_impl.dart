import 'package:rick_and_morty/data/%20implements/rick_and_morty_api_repository.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';
import 'package:rick_and_morty/domain/repository/sqflite_character_repository.dart';

class CharacterRepositoryImpl {
  final SqfliteCharacterRepository _local;
  final RickAndMortyApiRepository _remote;

  CharacterRepositoryImpl({
    required SqfliteCharacterRepository local,
    required RickAndMortyApiRepository remote,
  }) : _remote = remote,
       _local = local;

  Future<List<CharacterData>> getCharacter() async {
    final cached = await _local.getAll();
    if (cached.isNotEmpty) return cached;
    try {
      final response = await _remote.getAll();
      final characters = response.results.map((e) => e.toDataModel()).toList();
      await _local.cached(characters);
      return characters;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CharacterData> getCharacterDetail(int id) async {
    final cached = await _local.getByID(id);
    if (cached != null) return cached;
    try {
      final response = await _remote.getFromId(id);
      final character = response.toDataModel();
      await _local.cached([character]);
      return character;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<CharacterData>> refresh() async {
    final response = await _remote.getAll();
    final characters = response.results.map((e) => e.toDataModel()).toList();
    await _local.cached(characters);
    return characters;
  }
}
