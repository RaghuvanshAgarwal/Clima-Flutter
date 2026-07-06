import 'package:clima/models/weather_detail_section_data.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final String _title;
  final List<WeatherDetailSectionData> _data;

  const DetailsCard({required this._title, required this._data});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              _title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Column(
              spacing: 4,
              children: _data.map((data) {
                index++;
                return Column(
                  children: [
                    _createRow(context, data.emoji, data.name, data.value),
                    if (index != _data.length) Divider(height: 2),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createRow(
  BuildContext context,
  String emoji,
  String name,
  String value,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '$emoji $name',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
