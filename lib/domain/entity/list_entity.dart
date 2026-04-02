import 'package:rick_and_morty/data/models/data_models/like_status.dart';
import 'package:rick_and_morty/data/models/data_models/life_status.dart';

class ListEntity {
  final int id;
  final String name;
  final String imageURL;
  final String species;
  final LifeStatus statusOfCharacter;
  final LikeStatus likeStatus;

  ListEntity({
    required this.name,
    required this.imageURL,
    required this.species,
    required this.statusOfCharacter,
    required this.likeStatus,
    required this.id,
  });

  ListEntity copyWith({
    int? id,
    String? name,
    String? imageURL,
    String? species,
    LifeStatus? statusOfCharacter,
    LikeStatus? likeStatus,
  }) {
    return ListEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageURL: imageURL ?? this.imageURL,
      species: species ?? this.species,
      statusOfCharacter: statusOfCharacter ?? this.statusOfCharacter,
      likeStatus: likeStatus ?? this.likeStatus,
    );
  }
}
