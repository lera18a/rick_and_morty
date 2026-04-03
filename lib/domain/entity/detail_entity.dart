import 'package:rick_and_morty/domain/models/like_status.dart';
import 'package:rick_and_morty/domain/models/life_status.dart';

class DetailEntity {
  final int id;
  final String gender;
  final String lastLocationPlace;
  final String firstLocationPlace;
  final String species;
  final String name;
  final String imageURL;
  final LifeStatus statusLife;
  final LikeStatus likeStatus;

  DetailEntity({
    required this.lastLocationPlace,
    required this.firstLocationPlace,
    required this.species,
    required this.name,
    required this.imageURL,
    required this.statusLife,
    required this.likeStatus,
    required this.id,
    required this.gender,
  });

  DetailEntity copyWith({
    int? id,
    String? name,
    String? imageURL,
    String? species,
    LifeStatus? statusLife,
    LikeStatus? likeStatus,
    String? gender,
    String? lastLocationPlace,
    String? firstLocationPlace,
  }) {
    return DetailEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageURL: imageURL ?? this.imageURL,
      species: species ?? this.species,
      likeStatus: likeStatus ?? this.likeStatus,
      lastLocationPlace: lastLocationPlace ?? this.lastLocationPlace,
      firstLocationPlace: firstLocationPlace ?? this.firstLocationPlace,
      statusLife: statusLife ?? this.statusLife,
      gender: gender ?? this.gender,
    );
  }
}
