import 'package:clima/models/weather_detail_section_data.dart';
import 'package:flutter/material.dart';

class WeatherDetailCard extends StatelessWidget {
  final WeatherDetailSectionData _data;
  WeatherDetailCard({required this._data});

  @override
  Widget build(BuildContext context) {
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
          children: [
            Text(_data.emoji, style: Theme.of(context).textTheme.headlineLarge),
            Text(
              _data.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _data.value,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
