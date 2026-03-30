import 'package:rick_and_morty/domain/repository/open_repository.dart';
import 'package:sqflite/sqlite_api.dart';

abstract interface class OpenSqfliteRepository
    implements OpenRepository<Database> {}
