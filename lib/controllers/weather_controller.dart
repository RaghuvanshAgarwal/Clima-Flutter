import 'package:clima/models/hour_forcast.dart';
import 'package:clima/models/temperature_unit.dart';
import 'package:clima/models/weather_data.dart';
import 'package:clima/models/weather_detail_section_data.dart';
import 'package:clima/utilities/time_helper.dart';

class WeatherController {
  WeatherData _weatherData;
  TemperatureUnit _temperatureUnit = TemperatureUnit.Celcius;

  set temperatureUnit(TemperatureUnit value) => _temperatureUnit = value;
  set weatherData(WeatherData data) => _weatherData = data;
  TemperatureUnit get temperatureUnit => _temperatureUnit;

  WeatherController({required this._weatherData});

  CurrentWeatherController get current =>
      CurrentWeatherController(_weatherData.current, _temperatureUnit);

  ForecastWeatherController get forcast => ForecastWeatherController(
    _weatherData.forecast?.forecastday?[0],
    _temperatureUnit,
  );

  LocationWeatherController get location => LocationWeatherController(
    location: _weatherData.location,
    unit: _temperatureUnit,
  );
}

class LocationWeatherController {
  final Location? _location;
  final TemperatureUnit _unit;

  LocationWeatherController({required this._location, required this._unit});

  String get cityName => _location?.name ?? '';
  String get dayTime {
    TimeHelper timeHelper = TimeHelper(_location?.localtime);
    return '${timeHelper.dayOfWeek} • ${timeHelper.formattedTimeWithMinutes}';
  }
}

class CurrentWeatherController {
  final Current? _current;
  final TemperatureUnit _unit;

  CurrentWeatherController(this._current, this._unit);

  int get temperature => switch (_unit) {
    TemperatureUnit.Celcius => _current?.tempC?.round() ?? 0,
    TemperatureUnit.Fahrenheit => _current?.tempF?.round() ?? 0,
  };

  int get feelsLike => switch (_unit) {
    TemperatureUnit.Celcius => _current?.feelslikeC?.round() ?? 0,
    TemperatureUnit.Fahrenheit => _current?.feelslikeF?.round() ?? 0,
  };

  String get icon => _current?.condition?.icon ?? '';
  String get condition => _current?.condition?.text ?? '';

  List<WeatherDetailSectionData> get weatherDetails {
    List<WeatherDetailSectionData> sectionDatas = [
      WeatherDetailSectionData(
        emoji: '💨',
        name: 'Wind',
        value: switch (_unit) {
          TemperatureUnit.Celcius => '${_current?.windKph?.round() ?? 0} km/h',
          TemperatureUnit.Fahrenheit =>
            '${_current?.windMph?.round() ?? 0} mph',
        },
      ),
      WeatherDetailSectionData(
        emoji: '💧',
        name: 'Humidity',
        value: '${_current?.humidity ?? 0}%',
      ),
      WeatherDetailSectionData(
        emoji: '👁️',
        name: 'Visibility',
        value: switch (_unit) {
          TemperatureUnit.Celcius => '${_current?.visKm?.round() ?? 0} km',
          TemperatureUnit.Fahrenheit =>
            '${_current?.visMiles?.round() ?? 0} miles',
        },
      ),
      WeatherDetailSectionData(
        emoji: '☁️',
        name: 'Cloud',
        value: '${_current?.cloud ?? 0}%',
      ),
      WeatherDetailSectionData(
        emoji: '🌡️',
        name: 'Pressure',
        value: switch (_unit) {
          TemperatureUnit.Celcius => '${_current?.pressureMb?.round() ?? 0} mb',
          TemperatureUnit.Fahrenheit =>
            '${_current?.pressureIn?.round() ?? 0} in',
        },
      ),
      WeatherDetailSectionData(
        emoji: '🌪️',
        name: 'Gust',
        value: switch (_unit) {
          TemperatureUnit.Celcius => '${_current?.gustKph?.round() ?? 0} km/h',
          TemperatureUnit.Fahrenheit =>
            '${_current?.gustMph?.round() ?? 0} mph',
        },
      ),
    ];
    return sectionDatas;
  }
}

class ForecastWeatherController {
  final Forecastday? _forecast;
  final TemperatureUnit _unit;

  ForecastWeatherController(this._forecast, this._unit);

  int get highTemp => switch (_unit) {
    TemperatureUnit.Celcius => _forecast?.day?.maxtempC?.round() ?? 0,
    TemperatureUnit.Fahrenheit => _forecast?.day?.maxtempF?.round() ?? 0,
  };

  int get lowTemp => switch (_unit) {
    TemperatureUnit.Celcius => _forecast?.day?.mintempC?.round() ?? 0,
    TemperatureUnit.Fahrenheit => _forecast?.day?.mintempF?.round() ?? 0,
  };

  List<HourForcast> getHourlyForcast() {
    List<HourForcast> data = [];

    int len = _forecast?.hour?.length ?? 0;
    for (var i = 0; i < len; i++) {
      TimeHelper timeHelper = TimeHelper(_forecast?.hour?[i].time);
      String? time = timeHelper.formattedTime;
      String? url = _forecast?.hour?[i].condition?.icon;
      int temp = switch (_unit) {
        TemperatureUnit.Celcius => _forecast?.hour?[i].tempC?.round() ?? 0,
        TemperatureUnit.Fahrenheit => _forecast?.hour?[i].tempF?.round() ?? 0,
      };
      data.add(HourForcast(time: time, url: url, temp: temp));
    }

    return data;
  }

  List<WeatherDetailSectionData> get astroDetails {
    List<WeatherDetailSectionData> data = [
      WeatherDetailSectionData(
        emoji: '🌅',
        name: 'Sunrise',
        value: sunRiseTime,
      ),
      WeatherDetailSectionData(emoji: '🌄', name: 'Sunset', value: sunSetTime),
      WeatherDetailSectionData(
        emoji: '🌕',
        name: 'Full Moon',
        value: '$moonIllumination%',
      ),
    ];
    return data;
  }

  String get sunRiseTime => _forecast?.astro?.sunrise ?? '';
  String get sunSetTime => _forecast?.astro?.sunset ?? '';
  int get moonIllumination => _forecast?.astro?.moonIllumination ?? 0;
}
