import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/models/life_status.dart';

class StatusOfCharacterWidget extends StatelessWidget {
  const StatusOfCharacterWidget({
    super.key,
    required this.species,
    this.colorOfStatus,
    required this.statusLife,
  });

  final String species;
  final Color? colorOfStatus;
  final LifeStatus statusLife;

  @override
  Widget build(BuildContext context) {
    final colorOfStatus = switch (statusLife) {
      LifeStatus.alive => Colors.green,
      LifeStatus.dead => Colors.red,
      LifeStatus.unknown => Colors.grey,
    };

    final status = switch (statusLife) {
      LifeStatus.alive => 'Alive',
      LifeStatus.dead => 'Dead',
      LifeStatus.unknown => 'Unknown',
    };
    return Row(
      mainAxisSize: .min,
      children: [
        Icon(Icons.circle, color: colorOfStatus, size: 15),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$status - $species',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
