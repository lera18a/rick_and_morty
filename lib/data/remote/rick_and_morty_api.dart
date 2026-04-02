import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/character/character.dart';
import 'package:rick_and_morty/data/models/full_character/full_character.dart';

class RickAndMortyApi {
  final Dio _dio;

  RickAndMortyApi({required Dio dio}) : _dio = dio;

  Future<FullCharacter> getAll(int page) async {
    try {
      final Response response = await _dio.get(
        '/character',
        queryParameters: {'page': page},
      );
      return FullCharacter.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }

  Future<Character> getFromId(int id) async {
    try {
      final Response response = await _dio.get('/character/$id');
      return Character.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }
}
