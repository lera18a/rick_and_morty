import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/data_models/like_status.dart';

class Like extends StatelessWidget {
  const Like({super.key, this.onPressedLike, required this.likeStatus});
  final void Function()? onPressedLike;
  final LikeStatus likeStatus;

  @override
  Widget build(BuildContext context) {
    final (icon) = switch (likeStatus) {
      LikeStatus.like => Icon(Icons.favorite, color: Colors.red),
      LikeStatus.unLike => Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey,
      ),
    };
    return IconButton(iconSize: 28, onPressed: onPressedLike, icon: icon);
  }
}
