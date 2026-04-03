import 'package:rick_and_morty/domain/models/pagination_result.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';

abstract interface class Repository {
  Stream<int> get likeUpdates;
  //все - сетевой - c пагинацией
  Future<PaginationResult<ListEntity>> getAll(int page);

  // Future<void> cached(List<T> entities);
  // для отдельной страницы
  // сначала кэш потом апи
  Future<DetailEntity?> getByID(int entityID);

  // страница с setting чтобы почистить кэш - navBar
  Future<void> clearCache();
  // лайкнутые -
  Future<List<ListEntity>> getLiked();
  // для того чтобы лайкнуть и сохранить в кэш сразу в бдшку
  Future<void> like(int id);
  Future<void> disLike(int id);
}
