import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/core/enviroment_variables.dart';
import 'package:rick_and_morty/data/%20implements/sqflite_character_repository_impl.dart';
import 'package:rick_and_morty/data/%20implements/open_sqflite_repository_impl.dart';
import 'package:rick_and_morty/data/api/character_repository_impl.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository_impl.dart';
import 'package:rick_and_morty/domain/repository/sqflite_character_repository.dart';
import 'package:rick_and_morty/domain/repository/open_sqflite_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<RickAndMortyApiRepository>(
    RickAndMortyApiRepositoryImpl(
      dio: Dio(BaseOptions(baseUrl: EnviromentVariables.host)),
    ),
  );
  getIt.registerSingleton<OpenSqfliteRepository>(OpenSqfliteRepositoryImpl());

  getIt.registerSingleton<SqfliteCharacterRepository>(
    SqfliteCharacterRepositoryImpl(database: getIt<OpenSqfliteRepository>()),
  );
  getIt.registerSingleton(
    CharacterRepositoryImpl(
      local: getIt<SqfliteCharacterRepository>(),
      remote: getIt<RickAndMortyApiRepository>(),
    ),
  );
}
