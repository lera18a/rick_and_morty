import 'package:rick_and_morty/domain/entity/character_data.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';

abstract interface class SqfliteCharacterRepository
    implements Repository<CharacterData> {}
