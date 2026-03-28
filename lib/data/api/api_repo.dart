import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/full_character/full_character.dart';

class ApiRepo {
  final String host;
  late final Dio _dio;

  ApiRepo({required this.host}) {
    _dio = Dio(BaseOptions(baseUrl: host));
  }

  Future<FullCharacter> getCharacters() async {
    try {
      final Response response = await _dio.get('/character');
      return FullCharacter.fromJson(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
