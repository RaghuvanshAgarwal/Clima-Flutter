class WeatherDetailSectionData {
  final String _emoji;
  final String _name;
  final String _value;

  String get emoji => _emoji;
  String get name => _name;
  String get value => _value;

  WeatherDetailSectionData({
    required this._emoji,
    required this._name,
    required this._value,
  });
}
