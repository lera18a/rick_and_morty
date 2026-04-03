import 'package:rick_and_morty/core/config/sqflite_database.dart';
import 'package:rick_and_morty/data/models/data_models/character_data.dart';
import 'package:rick_and_morty/data/models/data_models/like_status.dart';
import 'package:sqflite/sqlite_api.dart';

class LocalDataSource {
  final SqliteDatabase database;
  LocalDataSource({required this.database});

  // clear cache
  // get liked
  Future<CharacterData?> getByID(int entityID) async {
    final db = await database.openData();
    final maps = await db.query(
      'character',
      where: 'id = ?',
      whereArgs: [entityID],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return CharacterData.fromDatabase(maps.first);
  }

  // все лайкнутые
  Future<List<CharacterData>> getLiked() async {
    final db = await database.openData();
    final maps = await db.query(
      'character',
      where: 'like_status = ?',
      whereArgs: [LikeStatus.like.index],
    );
    return maps.map((e) => CharacterData.fromDatabase(e)).toList();
  }

  // лайкнутые - айдишники
  Future<Set<int>> getLikedIds() async {
    final db = await database.openData();
    final maps = await db.query(
      'character',
      columns: ['id'],
      where: 'like_status = 1',
    );
    return maps.map((e) => e['id'] as int).toSet();
  }

  Future<void> cachedOne(CharacterData characterData) async {
    final db = await database.openData();
    await db.insert(
      conflictAlgorithm: ConflictAlgorithm.replace,
      'character',
      characterData.toDatabase(),
    );
  }

  Future<void> clearCachedAll() async {
    final db = await database.openData();
    await db.delete('character');
  }

  Future<void> clearOneOfCached(int id) async {
    final db = await database.openData();
    await db.delete('character', where: 'id = ?', whereArgs: [id]);
  }

  Future<LikeStatus> toggleLike(int entityID) async {
    final db = await database.openData();

    final result = await db.query(
      'character',
      where: 'id = ?',
      whereArgs: [entityID],
    );

    if (result.isEmpty) {
      return LikeStatus.unLike;
    }

    final currentStatus = LikeStatus.fromInt(
      result.first['like_status'] as int,
    );
    final newStatus = currentStatus.toggle();

    if (newStatus == LikeStatus.unLike) {
      await db.delete('character', where: 'id = ?', whereArgs: [entityID]);
    } else {
      await db.update(
        'character',
        {'like_status': newStatus.index},
        where: 'id = ?',
        whereArgs: [entityID],
      );
    }

    return newStatus;
  }
}
