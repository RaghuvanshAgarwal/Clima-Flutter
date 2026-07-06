import 'package:flutter/material.dart';

class CurrentTemperatureContainer extends StatelessWidget {
  final String url;
  final int temp;
  final String condition;
  final int feelsLike;
  final int highTemp;
  final int lowTemp;

  CurrentTemperatureContainer({
    required this.url,
    required this.temp,
    required this.condition,
    required this.feelsLike,
    required this.highTemp,
    required this.lowTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.network(
            'https:${url}',
            fit: BoxFit.fill,
            width: 100,
            height: 100,
          ),
        ),
        Text(
          '${temp}°',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          condition,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          'Feels like ${feelsLike}°',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'H: $highTemp°',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'L: $lowTemp°',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
