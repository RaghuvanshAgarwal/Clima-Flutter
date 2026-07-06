import 'package:clima/components/weather_detail_card.dart';
import 'package:clima/models/weather_detail_section_data.dart';
import 'package:flutter/material.dart';

class WeatherDetailSection extends StatelessWidget {
  final List<WeatherDetailSectionData> _details;
  WeatherDetailSection({required this._details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather Details',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _details.map((data) {
              return WeatherDetailCard(data: data);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
