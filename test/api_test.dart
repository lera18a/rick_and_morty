import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/core/enviroment_variables.dart';
import 'package:rick_and_morty/data/api/api_repo.dart';

void main() {
  final apiClient = ApiRepo(host: EnviromentVariables.apiHost);

  group('Get characters group', () {
    test('Get characters result', () async {
      final response = await apiClient.getCharacters();
      expect(response.results.isNotEmpty, true);
    });
    test('Get characters info', () async {
      final response = await apiClient.getCharacters();
      expect(response.info.pages != 0, true);
    });
  });
}
