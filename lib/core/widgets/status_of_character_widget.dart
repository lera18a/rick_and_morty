import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/widgets/status_life.dart';

class StatusOfCharacterWidget extends StatelessWidget {
  const StatusOfCharacterWidget({
    super.key,
    required this.species,
    this.colorOfStatus,
    required this.statusLife,
  });

  final String species;
  final Color? colorOfStatus;
  final StatusLife statusLife;

  // const StatusOfCharacterWidget.unknow({
  //   super.key,
  //   required String status,
  //   required String species,
  // }) : _species = species,
  //      _status = status,
  //      _colorOfStatus = Colors.grey;

  // const StatusOfCharacterWidget.alive({
  //   super.key,
  //   required String status,
  //   required String species,
  // }) : _species = species,
  //      _status = status,
  //      _colorOfStatus = Colors.green;

  // const StatusOfCharacterWidget.dead({
  //   super.key,
  //   required String status,
  //   required String species,
  // }) : _species = species,
  //      _status = status,
  //      _colorOfStatus = Colors.red;

  @override
  Widget build(BuildContext context) {
    final colorOfStatus = switch (statusLife) {
      StatusLife.alive => Colors.green,
      StatusLife.dead => Colors.red,
      StatusLife.unknown => Colors.grey,
    };

    final status = switch (statusLife) {
      StatusLife.alive => 'Alive',
      StatusLife.dead => 'Dead',
      StatusLife.unknown => 'Unknown',
    };
    return Row(
      mainAxisSize: .min,
      children: [
        Icon(Icons.circle, color: colorOfStatus, size: 15),
        const SizedBox(width: 10),
        Text(
          '$status - $species',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
