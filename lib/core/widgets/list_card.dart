import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/widgets/like.dart';
import 'package:rick_and_morty/data/models/data_models/like_status.dart';
import 'package:rick_and_morty/data/models/data_models/life_status.dart';
import 'package:rick_and_morty/core/widgets/status_of_character_widget.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.name,
    required this.imageURL,
    required this.species,
    this.onTap,
    required this.statusOfCharacter,
    required this.likeStatus,
    this.onPressedLike,
  });
  final String name;
  final String imageURL;
  final String species;
  final void Function()? onTap;
  final LifeStatus statusOfCharacter;
  final LikeStatus likeStatus;
  final void Function()? onPressedLike;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        color: Colors.black54,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: .stretch,
                children: [
                  SizedBox(
                    width: 120,
                    child: Image.network(imageURL, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          StatusOfCharacterWidget(
                            species: species,
                            statusLife: statusOfCharacter,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Like(likeStatus: likeStatus, onPressedLike: onPressedLike),
            ),
          ],
        ),
      ),
    );
  }
}
