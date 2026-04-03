import 'package:rick_and_morty/data/remote/pagination/pagination_result.dart';

abstract interface class Repository<T, K> {
  //все - сетевой - c пагинацией
  Future<PaginationResult<T>> getAll(int page);

  // Future<void> cached(List<T> entities);
  // для отдельной страницы
  // сначала кэш потом апи
  Future<T?> getByID(int entityID);

  // страница с setting чтобы почистить кэш - navBar
  Future<void> clearCache();
  // лайкнутые -
  Future<List<T>> getLiked();
  // для того чтобы лайкнуть и сохранить в кэш сразу в бдшку
  Future<T> toggleLike(K entity);
}
