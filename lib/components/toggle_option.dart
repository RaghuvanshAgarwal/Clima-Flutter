import 'package:flutter/material.dart';

class ToggleOption extends StatelessWidget {
  final String _label;
  final bool _selected;
  final Function onPressed;

  ToggleOption({
    required this._label,
    required this._selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Pressed');
        onPressed();
      },
      child: Container(
        child: Center(
          child: Text(
            _label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _selected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
