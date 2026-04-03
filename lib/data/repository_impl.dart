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

  Future<void> clearCache() async {
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

  //
  Future<CharacterData?> getByID(int entityID) async {
    final local = await _local.getByID(entityID);
    if (local != null) return local;
    return await _remote.getById(entityID);
  }

  Future<List<CharacterData>> getLiked() async {
    return await _local.getLiked();
  }

  //проверяем локально-> если нет то ходим в сеть-> если нет то ошибку
  Future<LikeStatus> _like(int id) async {
    var character = await _local.getByID(id);
    if (character == null) {
      //вызвала character по id
      character = await _remote.getById(id);
      if (character == null) {
        throw Exception('Character with $id not found');
      }
    }
    final liked = character.copyWith(likeStatus: LikeStatus.like);
    await _local.cachedOne(liked);
    _likeUpdates.add(id);
    return LikeStatus.like;
  }

  Future<LikeStatus> _disLike(int id) async {
    var character = await _local.getByID(id);
    if (character == null) {
      throw Exception('Character with $id not found');
    }
    await _local.clearOneOfCached(id);
    _likeUpdates.add(id);
    return LikeStatus.unLike;
  }

  Future<LikeStatus> toggleLike(int id) async {
    final character = await _local.getByID(id);
    if (character == null) {
      return await _like(id);
    } else {
      return await _disLike(id);
    }
  }
}
