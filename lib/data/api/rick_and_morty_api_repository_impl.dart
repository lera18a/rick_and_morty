import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository.dart';
import 'package:rick_and_morty/data/models/character/character.dart';
import 'package:rick_and_morty/data/models/full_character/full_character.dart';

class RickAndMortyApiRepositoryImpl implements RickAndMortyApiRepository {
  final Dio _dio;

  RickAndMortyApiRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<FullCharacter> getAll() async {
    try {
      final Response response = await _dio.get('/character');
      return FullCharacter.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        '`${e.message} : ${e.error.toString()}';
      }
      if (e.type == DioExceptionType.badResponse) {
        e.message;
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        e.message;
      }
      // if (e.type == DioExceptionType.unknown) {
      //   HandleException.cacheError(statusCode: );
      // }
      print(e.message);
      rethrow;
    }
  }

  @override
  Future<Character> getFromId(int id) async {
    try {
      final Response response = await _dio.get('/character/$id');
      return Character.fromJson(response.data);
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
