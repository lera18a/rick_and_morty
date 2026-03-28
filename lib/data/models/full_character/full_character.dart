import 'package:rick_and_morty/data/models/character/character.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/data/models/info/information.dart';

part 'full_character.g.dart';

@JsonSerializable()
class FullCharacter {
  final Information info;
  final List<Character> results;

  FullCharacter({required this.info, required this.results});

  factory FullCharacter.fromJson(Map<String, dynamic> json) =>
      _$FullCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$FullCharacterToJson(this);
}
