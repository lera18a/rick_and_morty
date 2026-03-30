import 'package:rick_and_morty/data/models/location/location.dart';
import 'package:rick_and_morty/data/models/origin/origin.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/domain/entity/character_data.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location location;
  final Origin origin;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  CharacterData toDataModel() {
    return CharacterData(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      locationName: location.name,
      locationUrl: location.url,
      originName: origin.name,
      originUrl: origin.url,
      image: image,
      episodes: episode,
      url: url,
      created: created,
      cachedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
