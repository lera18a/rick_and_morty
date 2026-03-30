import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/enviroment_variables.dart';
import 'package:rick_and_morty/data/api/character_repository_impl.dart';
import 'package:rick_and_morty/data/%20implements/sqflite_character_repository_impl.dart';
import 'package:rick_and_morty/data/%20implements/open_sqflite_repository_impl.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository.dart';
import 'package:rick_and_morty/data/api/rick_and_morty_api_repository_impl.dart';
import 'package:rick_and_morty/domain/repository/sqflite_character_repository.dart';
import 'package:rick_and_morty/domain/repository/open_sqflite_repository.dart';

class Injector extends StatelessWidget {
  const Injector({super.key, required Widget child}) : _child = child;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //сначала апишка -> потом бдшка -> потом остальное
        //а может и наоборот
        //в зависимости от вызовов
        Provider<RickAndMortyApiRepository>(
          create: (context) => RickAndMortyApiRepositoryImpl(
            dio: Dio(BaseOptions(baseUrl: EnviromentVariables.host)),
          ),
        ),
        Provider<OpenSqfliteRepository>(
          create: (context) => OpenSqfliteRepositoryImpl(),
        ),
        Provider<SqfliteCharacterRepository>(
          create: (context) =>
              SqfliteCharacterRepositoryImpl(database: context.read()),
        ),
        Provider(
          create: (context) => CharacterRepositoryImpl(
            local: context.read(),
            remote: context.read(),
          ),
        ),
      ],
      child: _child,
    );
  }
}
