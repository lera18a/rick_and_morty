import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/data_models/character_data.dart';
import 'package:rick_and_morty/data/remote/pagination/pagination_result.dart';
import 'package:rick_and_morty/data/remote/rick_and_morty_api.dart';

class RemotePagination {
  final RickAndMortyApi _remote;

  RemotePagination({required RickAndMortyApi remote}) : _remote = remote;

  Future<PaginationResult<CharacterData>> getPage(int page) async {
    final fullCharacters = await _remote.getAll(page);

    final character = fullCharacters.results
        .map((characterData) => characterData.toDataModel())
        .toList();

    final nextUrl = fullCharacters.info.next;
    final nextPage = _hasNextPageOrNo(nextUrl);
    return PaginationResult(
      items: character,
      hasMore: nextPage != null,
      nextPage: nextPage,
    );
  }

  Future<CharacterData?> getById(int id) async {
    try {
      final character = await _remote.getFromId(id);
      return character.toDataModel();
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
