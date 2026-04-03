//из бдшки в Entity
import 'package:rick_and_morty/data/models/data_models/character_data.dart';
import 'package:rick_and_morty/domain/entity/detail_entity.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';

// из бдшки в модель - entity
// из entity в бдшку
class Mapper {
  // в модель -> DetailEntity

  static DetailEntity toDetail(CharacterData characterData) => DetailEntity(
    lastLocationPlace: characterData.locationName,
    firstLocationPlace: characterData.originName,
    species: characterData.species,
    name: characterData.name,
    imageURL: characterData.image,
    statusLife: characterData.status,
    likeStatus: characterData.likeStatus,
    id: characterData.id,
    gender: characterData.gender,
  );

  // в модель -> ListEntity
  static ListEntity toListEntity(CharacterData characterData) => ListEntity(
    name: characterData.name,
    imageURL: characterData.image,
    species: characterData.species,
    statusOfCharacter: characterData.status,
    likeStatus: characterData.likeStatus,
    id: characterData.id,
  );

  //в бдшку из DetailEntity -> CharacterData
  static CharacterData detailsToData(DetailEntity detailEntity) {
    return CharacterData(
      id: detailEntity.id,
      name: detailEntity.name,
      status: detailEntity.statusLife,
      species: detailEntity.species,
      gender: detailEntity.gender,
      locationName: detailEntity.lastLocationPlace,
      originName: detailEntity.firstLocationPlace,
      image: detailEntity.imageURL,
      likeStatus: detailEntity.likeStatus,
    );
  }
}
