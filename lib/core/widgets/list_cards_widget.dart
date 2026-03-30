import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/widgets/info_widget.dart';
import 'package:rick_and_morty/core/widgets/status_of_character_widget.dart';

class ListCardsWidget extends StatelessWidget {
  const ListCardsWidget({
    super.key,
    required this.lastLocationPlace,
    required this.firstLocationPlace,
    required this.status,
    required this.species,
    required this.name,
    required this.imageURL,
    this.onTap,
    this.childen,
  });
  final String lastLocationPlace;
  final String firstLocationPlace;
  final String status;
  final String species;
  final String name;
  final String imageURL;
  final void Function()? onTap;
  final List<Widget>? childen;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageURL, fit: BoxFit.cover),
              ),
            ),
            Padding(
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
                      fontSize: 25,
                    ),
                  ),
                  StatusOfCharacterWidget.alive(
                    status: status,
                    species: species,
                  ),
                  InfoWidget.lastLocation(place: firstLocationPlace),
                  InfoWidget.firstLocation(place: lastLocationPlace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
