// можно потом сделать отдельно
// location - model и origin - модель
import 'dart:convert';

import 'package:rick_and_morty/core/widgets/status_life.dart';

class CharacterData {
  final int id;
  final String name;
  final StatusLife status;
  final String species;
  final String type;
  final String gender;
  final String locationName;
  final String locationUrl;
  final String originName;
  final String originUrl;
  final String image;
  final List<String> episodes;
  final String url;
  final String created;
  final int cachedAt;
  final bool isLiked;

  const CharacterData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.locationName,
    required this.locationUrl,
    required this.originName,
    required this.originUrl,
    required this.image,
    required this.episodes,
    required this.url,
    required this.created,
    required this.cachedAt,
    required this.isLiked,
  });

  // в базу
  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
      'species': species,
      'type': type,
      'gender': gender,
      'location_name': locationName,
      'location_url': locationUrl,
      'origin_name': originName,
      'origin_url': originUrl,
      'image': image,
      'episodes': jsonEncode(episodes),
      'url': url,
      'created': created,
      'cached_at': cachedAt,
      'is_liked': isLiked ? 1 : 0,
    };
  }

  // из базы
  factory CharacterData.fromDatabase(Map<String, dynamic> data) {
    return CharacterData(
      id: data['id'] as int,
      name: data['name'] as String,
      status: StatusLife.fromString(data['status'] as String),
      species: data['species'] as String,
      type: data['type'] as String,
      gender: data['gender'] as String,
      locationName: data['location_name'] as String,
      locationUrl: data['location_url'] as String,
      originName: data['origin_name'] as String,
      originUrl: data['origin_url'] as String,
      image: data['image'] as String,
      episodes: (jsonDecode(data['episodes'] as String) as List)
          .map((e) => e as String)
          .toList(),
      url: data['url'] as String,
      created: data['created'] as String,
      cachedAt: data['cached_at'] as int,
      isLiked: (data['is_liked'] as int) == 1,
    );
  }
  CharacterData copyWith({bool? isLiked}) {
    return CharacterData(
      id: id,
      name: name,
      status: status,
      isLiked: isLiked ?? this.isLiked,
      species: species,
      type: type,
      gender: gender,
      locationName: locationName,
      locationUrl: locationUrl,
      originName: originName,
      originUrl: originUrl,
      image: image,
      episodes: episodes,
      url: url,
      created: created,
      cachedAt: cachedAt,
    );
  }
}
