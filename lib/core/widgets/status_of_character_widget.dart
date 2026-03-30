import 'package:flutter/material.dart';

class StatusOfCharacterWidget extends StatelessWidget {
  const StatusOfCharacterWidget({
    super.key,
    required String status,
    required String species,
    Color? colorOfStatus,
  }) : _colorOfStatus = colorOfStatus,
       _species = species,
       _status = status;
  final String _status;
  final String _species;
  final Color? _colorOfStatus;

  const StatusOfCharacterWidget.unknow({
    super.key,
    required String status,
    required String species,
  }) : _species = species,
       _status = status,
       _colorOfStatus = Colors.grey;

  const StatusOfCharacterWidget.alive({
    super.key,
    required String status,
    required String species,
  }) : _species = species,
       _status = status,
       _colorOfStatus = Colors.green;

  const StatusOfCharacterWidget.dead({
    super.key,
    required String status,
    required String species,
  }) : _species = species,
       _status = status,
       _colorOfStatus = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        Icon(Icons.circle, color: _colorOfStatus, size: 15),
        const SizedBox(width: 10),
        Text(
          '$_status - $_species',
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
