import 'dart:async';

import 'package:rick_and_morty/data/local/local_data_source.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/domain/models/like_status.dart';
import 'package:rick_and_morty/domain/models/pagination_result.dart';
import 'package:rick_and_morty/data/remote/pagination/remote_pagination.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _local;
  final RemotePagination _remote;
  final _likeUpdates = StreamController<int>.broadcast();
  @override
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

  @override
  Future<void> clearCache() async {
    await _local.clearCachedAll();
  }

  Future<void> clearOneCached(int id) async {
    await _local.clearOneOfCached(id);
  }

  // сетевой- получили все
  @override
  Future<PaginationResult<ListEntity>> getAll(int page) async {
    final result = await _remote.getPage(page);
    final itemsWithLikes = result.items
        .map((listEntity) => listEntity)
        .toList();
    return PaginationResult(
      items: itemsWithLikes,
      hasMore: result.hasMore,
      nextPage: result.nextPage,
    );
  }

  //
  @override
  Future<DetailEntity?> getByID(int entityID) async {
    final remote = await _remote.getById(entityID);
    final local = await _local.getByID(entityID);
    final likeStatus = local?.likeStatus ?? LikeStatus.unLike;
    if (remote != null) {
      return remote.copyWith(likeStatus: likeStatus);
    } else {
      if (local != null) return Mapper.toDetail(local);
    }
    return null;
  }

  @override
  Future<List<ListEntity>> getLiked() async {
    final characters = await _local.getLiked();
    final listEntities = characters.map((e) => Mapper.toListEntity(e)).toList();
    return listEntities;
  }

  //проверяем локально-> если нет то ходим в сеть-> если нет то ошибку
  @override
  Future<void> like(int id) async {
    final detail = await getByID(id);
    if (detail == null) {
      throw Exception('Character with $id not found');
    }
    final likedDetail = detail.copyWith(likeStatus: LikeStatus.like);
    final likedCharacter = Mapper.detailsToData(likedDetail);
    await _local.cachedOne(likedCharacter);
    _likeUpdates.add(id);
  }

  @override
  Future<void> disLike(int id) async {
    var character = await getByID(id);
    if (character == null) {
      throw Exception('Character with $id not found');
    }
    await _local.clearOneOfCached(id);
    _likeUpdates.add(id);
  }
}
