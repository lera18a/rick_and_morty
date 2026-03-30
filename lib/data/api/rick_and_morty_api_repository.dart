import 'package:rick_and_morty/data/api/api_repository.dart';
import 'package:rick_and_morty/data/models/character/character.dart';
import 'package:rick_and_morty/data/models/full_character/full_character.dart';

abstract interface class RickAndMortyApiRepository
    implements ApiRepository<FullCharacter, Character> {}
