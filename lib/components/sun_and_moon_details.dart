import 'package:flutter/material.dart';

class SunAndMoonDetails extends StatelessWidget {
  final String _sunRiseTime;
  final String _sunSetTime;
  final int _moonIllumination;

  const SunAndMoonDetails({
    super.key,
    required this._sunRiseTime,
    required this._sunSetTime,
    required this._moonIllumination,
  });

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
          spacing: 12,
          children: [
            Text(
              'Sun & Moon',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Column(
              spacing: 4,
              children: [
                _createRow(context, '🌅', 'Sunrise', _sunRiseTime),
                Divider(height: 2),
                _createRow(context, '🌄', 'Sunset', _sunSetTime),
                Divider(height: 2),
                _createRow(context, '🌕', 'Full Moon', '$_moonIllumination%'),
              ],
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
      Text('$emoji $name', style: Theme.of(context).textTheme.titleMedium),
      Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
