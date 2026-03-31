enum LikeStatus {
  like,
  unLike;

  factory LikeStatus.fromInt(int value) {
    switch (value) {
      case 0:
        return LikeStatus.unLike;
      case 1:
        return LikeStatus.like;
      default:
        return LikeStatus.unLike;
    }
  }
}
