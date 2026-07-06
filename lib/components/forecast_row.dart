import 'package:clima/models/hour_forcast.dart';
import 'package:flutter/material.dart';

class ForecastRow extends StatelessWidget {
  final List<HourForcast> _data;
  ForecastRow({required this._data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Forecast',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _data.map((data) {
                  return _createForcastCard(context, data);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _createForcastCard(BuildContext context, HourForcast forcast) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(20),
    ),
    child: Container(
      width: 125,
      height: 125,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            forcast.time ?? 'Error',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          Image.network(
            width: 50,
            height: 50,
            forcast.url != null
                ? 'https:${forcast.url}'
                : 'https://cdn.weatherapi.com/weather/64x64/night/116.png',
          ),
          Text(
            '${forcast.temp ?? 0}°',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    ),
  );
}
