import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/core/enviroment_variables.dart';
import 'package:rick_and_morty/data/local/local_data_source.dart';
import 'package:rick_and_morty/core/config/sqflite_database.dart';
import 'package:rick_and_morty/data/remote/pagination/remote_pagination.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/data/remote/rick_and_morty_api.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton(
    RickAndMortyApi(dio: Dio(BaseOptions(baseUrl: EnviromentVariables.host))),
  );

  getIt.registerSingleton(SqliteDatabase());

  getIt.registerSingleton(RemotePagination(remote: getIt<RickAndMortyApi>()));

  getIt.registerSingleton(LocalDataSource(database: getIt<SqliteDatabase>()));
  getIt.registerSingleton<Repository>(
    RepositoryImpl(
      local: getIt<LocalDataSource>(),
      remote: getIt<RemotePagination>(),
    ),
  );
}
