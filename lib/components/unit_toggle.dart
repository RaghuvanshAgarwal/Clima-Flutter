import 'package:clima/components/toggle_option.dart';
import 'package:flutter/material.dart';

class UnitToggle extends StatefulWidget {
  final String _option1;
  final String _option2;
  final Function(int) _onValueChanged;
  int _selectedOption;

  int get selectedOption => _selectedOption;

  UnitToggle({
    required this._option1,
    required this._option2,
    required this._onValueChanged,
    required this._selectedOption,
  });

  @override
  State<UnitToggle> createState() => _UnitToggleState();
}

class _UnitToggleState extends State<UnitToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(25),
      ),

      height: 50,
      padding: EdgeInsets.all(6),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            alignment: widget._selectedOption == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  //color: Colors.amber,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ToggleOption(
                  label: widget._option1,
                  selected: widget._selectedOption == 0,
                  onPressed: () {
                    setState(() {
                      updateValue(0);
                    });
                  },
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: ToggleOption(
                  label: widget._option2,
                  selected: widget._selectedOption == 1,
                  onPressed: () {
                    setState(() {
                      updateValue(1);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateValue(int newValue) {
    if (widget._selectedOption == newValue) return;
    widget._selectedOption = newValue;
    widget._onValueChanged(widget._selectedOption);
  }
}
