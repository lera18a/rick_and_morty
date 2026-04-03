import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/domain/models/pagination_result.dart';
import 'package:rick_and_morty/data/remote/rick_and_morty_api.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';

class RemotePagination {
  final RickAndMortyApi _remote;

  RemotePagination({required RickAndMortyApi remote}) : _remote = remote;

  Future<PaginationResult<ListEntity>> getPage(int page) async {
    //беру удаленные
    final fullCharacters = await _remote.getAll(page);
    // список сharacter достаю
    final character = fullCharacters.results
        .map((characterData) => characterData.toDataModel())
        .toList();
    //также достаю listEntity
    final listEntity = character
        .map((character) => Mapper.toListEntity(character))
        .toList();

    final nextUrl = fullCharacters.info.next;
    final nextPage = _hasNextPageOrNo(nextUrl);
    return PaginationResult(
      items: listEntity,
      hasMore: nextPage != null,
      nextPage: nextPage,
    );
  }

  Future<DetailEntity?> getById(int id) async {
    try {
      final character = await _remote.getFromId(id);
      final characterData = character.toDataModel();
      return Mapper.toDetail(characterData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }
}

int? _hasNextPageOrNo(String? url) {
  if (url == null) return null;
  final uri = Uri.parse(url);
  final page = uri.queryParameters['page'];
  final next = page != null ? int.tryParse(page) : null;
  return next;
}
