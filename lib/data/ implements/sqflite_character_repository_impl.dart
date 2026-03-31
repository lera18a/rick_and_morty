import 'package:rick_and_morty/domain/entity/character_data.dart';
import 'package:rick_and_morty/domain/repository/sqflite_character_repository.dart';
import 'package:rick_and_morty/domain/repository/open_sqflite_repository.dart';

class SqfliteCharacterRepositoryImpl implements SqfliteCharacterRepository {
  final OpenSqfliteRepository database;

  SqfliteCharacterRepositoryImpl({required this.database});

  @override
  Future<void> cached(List<CharacterData> entities) async {
    final db = await database.openData();
    final batch = db.batch();

    for (var character in entities) {
      batch.insert('character', character.toDatabase());
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> clearCache() async {
    final database = await this.database.openData();
    await database.delete('character');
  }

  @override
  Future<List<CharacterData>> getAll() async {
    final database = await this.database.openData();
    final maps = await database.query('character');
    return maps.map((e) => CharacterData.fromDatabase(e)).toList();
  }

  @override
  Future<CharacterData?> getByID(int entityID) async {
    final database = await this.database.openData();
    final maps = await database.query(
      'character',
      where: 'id = ?',
      whereArgs: [entityID],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return CharacterData.fromDatabase(maps.first);
  }

  @override
  Future<List<CharacterData>> getLiked() async {
    final database = await this.database.openData();
    final maps = await database.query('character', where: 'is_liked = 1');
    return maps.map((e) => CharacterData.fromDatabase(e)).toList();
  }

  @override
  Future<void> toggleLike(int entityID) async {
    final database = await this.database.openData();
    final List<Map<String, dynamic>> result = await database.query(
      'character',
      where: 'is_liked = ?',
      whereArgs: [entityID],
    );
    if (result.isNotEmpty) {
      final int liked = result.first['is_liked'];
      final int newValue = liked == 1 ? 0 : 1;
      await database.update(
        'character',
        {'is_liked': newValue},
        where: 'id = ?',
        whereArgs: [entityID],
      );
    }
  }
}
