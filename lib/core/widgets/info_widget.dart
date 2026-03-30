import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, String title = '', required String place})
    : _place = place,
      _title = title;
  final String _title;
  final String _place;

  const InfoWidget.firstLocation({super.key, required String place})
    : _place = place,
      _title = 'First seen in:';

  const InfoWidget.lastLocation({super.key, required String place})
    : _place = place,
      _title = 'Last known location:';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(_title, style: TextStyle(color: Colors.grey, fontSize: 21)),
        Text(_place, style: TextStyle(color: Colors.white, fontSize: 23)),
      ],
    );
  }
}
