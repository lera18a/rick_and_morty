import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/widgets/status_of_character_widget.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.name,
    required this.imageURL,
    required this.status,
    required this.species,
    this.onTap,
  });
  final String name;
  final String imageURL;
  final String status;
  final String species;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        color: Colors.black54,
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      StatusOfCharacterWidget.alive(
                        status: status,
                        species: species,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
