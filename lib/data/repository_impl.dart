import 'dart:async';

import 'package:rick_and_morty/data/local/local_data_source.dart';
import 'package:rick_and_morty/data/models/data_models/like_status.dart';
import 'package:rick_and_morty/data/remote/pagination/pagination_result.dart';
import 'package:rick_and_morty/data/remote/remote_pagination.dart';
import 'package:rick_and_morty/data/models/data_models/character_data.dart';

class RepositoryImpl {
  final LocalDataSource _local;
  final RemotePagination _remote;
  final _likeUpdates = StreamController<int>.broadcast();
  Stream<int> get likeUpdates => _likeUpdates.stream;

  // если есть сеть то ходим в api, если нет то в бдшку
  // если нет интернета то отображаю что нет интернета
  // кнопка на обновление
  // сранвниваем по id - шнику
  //
  RepositoryImpl({
    required LocalDataSource local,
    required RemotePagination remote,
  }) : _remote = remote,
       _local = local;
  //возвращает лайкнутые
  //возвращает апишки
  //сверяем айдишник
  //если есть лайкнутый то берем из бд
  //если нет то подгружаем

  // Future<List<CharacterData>> getLikedWithDatabase() async {
  //   final liked = await _local.getLiked();
  //   if (liked.isNotEmpty) return;
  // }

  //выдает всех если
  // Future<PaginationResult<CharacterData>> getCharacters(int page) async {
  //   final cached = await _local.getAll();
  //   if (cached.isNotEmpty) return cached;
  //   try {
  //     final response = await _remote.getAll();
  //     final characters = response.results.map((e) => e.toDataModel()).toList();
  //     await _local.cached(characters);
  //     return characters;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<CharacterData> getCharacterDetail(int id) async {
  //   final cached = await _local.getByID(id);
  //   if (cached != null) return cached;
  //   try {
  //     final response = await _remote.getFromId(id);
  //     final character = response.toDataModel();
  //     await _local.cached([character]);
  //     return character;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<List<CharacterData>> refresh() async {
  //   final response = await _remote.getAll();
  //   final characters = response.results.map((e) => e.toDataModel()).toList();
  //   await _local.cached(characters);
  //   return characters;
  // }

  Future<void> clearCache() async {
    //чистим локально кэш сохраняет в бд
    await _local.clearCachedAll();
  }

  // сетевой- получили все
  Future<PaginationResult<CharacterData>> getAll(int page) async {
    final result = await _remote.getPage(page);
    final likedIds = await _local.getLikedIds();
    final itemsWithLikes = result.items.map((character) {
      if (likedIds.contains(character.id)) {
        return character.copyWith(likeStatus: LikeStatus.like);
      }
      return character;
    }).toList();

    return PaginationResult(
      items: itemsWithLikes,
      hasMore: result.hasMore,
      nextPage: result.nextPage,
    );
  }

  Future<CharacterData?> getByID(int entityID) async {
    final local = await _local.getByID(entityID);
    if (local != null) return local;
    return await _remote.getById(entityID);
  }

  Future<List<CharacterData>> getLiked() async {
    return await _local.getLiked();
  }

  Future<LikeStatus> toggleLike(CharacterData entity) async {
    final local = await _local.getByID(entity.id);
    LikeStatus newStatus;
    if (local == null) {
      final liked = entity.copyWith(likeStatus: LikeStatus.like);
      await _local.cachedOne(liked);
      newStatus = LikeStatus.like;
    } else {
      newStatus = await _local.toggleLike(entity.id);
    }
    _likeUpdates.add(entity.id);
    return newStatus;
  }
}
