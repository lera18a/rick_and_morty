import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/widgets/info_widget.dart';
import 'package:rick_and_morty/core/widgets/status_life.dart';
import 'package:rick_and_morty/core/widgets/status_of_character_widget.dart';

class DetailCardWidget<T> extends StatelessWidget {
  const DetailCardWidget({
    super.key,
    required this.lastLocationPlace,
    required this.firstLocationPlace,
    required this.species,
    required this.name,
    required this.imageURL,
    required this.character,
    required this.statusLife,
  });
  final T character;
  final String lastLocationPlace;
  final String firstLocationPlace;
  final String species;
  final String name;
  final String imageURL;
  final StatusLife statusLife;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
                StatusOfCharacterWidget(
                  species: species,
                  statusLife: statusLife,
                ),
                InfoWidget.lastLocation(place: firstLocationPlace),
                InfoWidget.firstLocation(place: lastLocationPlace),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
