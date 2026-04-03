enum LikeStatus {
  unLike, // 0
  like; // 1

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
  LikeStatus toggle() {
    return this == LikeStatus.like ? LikeStatus.unLike : LikeStatus.like;
  }
}
