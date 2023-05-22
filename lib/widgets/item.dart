import 'package:flutter/material.dart';
import 'package:kinopoisk/models/kino.dart';

class KinoListItem extends StatelessWidget {
  final KinoModel kino;

  const KinoListItem(this.kino, {super.key});

  String _getName() {
    String? name = kino.name;
    String? alternativeName = kino.alternativeName;
    List<dynamic>? names = kino.names;

    if (name != null && name.isNotEmpty) {
      return name;
    } else if (alternativeName != null && alternativeName.isNotEmpty) {
      return alternativeName;
    } else if (names != null && names.isNotEmpty) {
      return names.first;
    } else {
      return '';
    }
  }

  String _getDescription() {
    String? description = kino.description;
    if (description != null && description.isNotEmpty) {
      return description;
    } else {
      return 'Описание отсутствует';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(_getName()),
      childrenPadding: const EdgeInsets.all(16),
      leading: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(kino.id.toString()),
      ),
      children: [
        Text(
          _getDescription(),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
