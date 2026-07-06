import 'dart:convert';

import 'package:clima/models/weather_data.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherService {
  Future<WeatherData> getCurrentLocationWeather() async {
    LocationData location = LocationData();
    await location.getCurrentLocation();
    print(
      'latitude: ${location.latitude} and longitude: ${location.longitude}',
    );
    NetworkHelper forcastData = NetworkHelper(
      uri: ApiHelper().forcastDataUriByLocation(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );

    String data = await forcastData.getData();
    return WeatherData.fromJson(jsonDecode(data));
  }

  Future<WeatherData> getNameLocationWeather({required String name}) async {
    NetworkHelper forcastData = NetworkHelper(
      uri: ApiHelper().forcastDataUriByName(name: name),
    );
    String data = await forcastData.getData();
    return WeatherData.fromJson(jsonDecode(data));
  }
}
