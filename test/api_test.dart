import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/core/enviroment_variables.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository_impl.dart';

void main() {
  final dio = Dio(BaseOptions(baseUrl: EnviromentVariables.host));
  final apiClient = RickAndMortyApiRepositoryImpl(dio: dio);

  group('Get characters group', () {
    test('Get characters result', () async {
      final response = await apiClient.getAll();
      expect(response.results.isNotEmpty, true);
    });
    test('Get characters info', () async {
      final response = await apiClient.getAll();
      expect(response.info.pages != 0, true);
    });
  });
}
