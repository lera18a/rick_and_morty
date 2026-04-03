import 'package:rick_and_morty/domain/models/like_status.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';

class LikeCharacterUseCase {
  final Repository repository;

  LikeCharacterUseCase({required this.repository});

  Future<LikeStatus> execuit(int id, LikeStatus likeStatus) async {
    switch (likeStatus) {
      case LikeStatus.unLike:
        await repository.like(id);
        return LikeStatus.like;
      case LikeStatus.like:
        await repository.disLike(id);
        return LikeStatus.unLike;
    }
  }
}
