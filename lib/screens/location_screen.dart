import 'package:clima/components/current_temperature_container.dart';
import 'package:clima/components/forecast_row.dart';
import 'package:clima/components/sun_and_moon_details.dart';
import 'package:clima/components/unit_toggle.dart';
import 'package:clima/controllers/weather_controller.dart';
import 'package:clima/models/temperature_unit.dart';
import 'package:clima/models/weather_data.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationScreen extends StatefulWidget {
  late final WeatherController _controller;

  LocationScreen({required WeatherData data}) {
    _controller = WeatherController(weatherData: data);
  }

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    CurrentWeatherController currentWeatherController =
        widget._controller.current;
    ForecastWeatherController forecastWeatherController =
        widget._controller.forcast;
    LocationWeatherController locationWeatherController =
        widget._controller.location;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoadingScreen();
                },
              ),
            );
          },
          child: FaIcon(FontAwesomeIcons.locationArrow),
        ),
        title: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                locationWeatherController.cityName,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Text(
              locationWeatherController.dayTime,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
            },
            child: FaIcon(FontAwesomeIcons.city),
          ),
        ],
        toolbarHeight: 72,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          width: double.infinity,
          child: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrentTemperatureContainer(
                url: currentWeatherController.icon,
                temp: currentWeatherController.temperature,
                condition: currentWeatherController.condition,
                feelsLike: currentWeatherController.feelsLike,
                highTemp: forecastWeatherController.highTemp,
                lowTemp: forecastWeatherController.lowTemp,
              ),
              UnitToggle(
                option1: 'Metric °C',
                option2: 'Imperial °F',
                selectedOption:
                    widget._controller.temperatureUnit ==
                        TemperatureUnit.Celcius
                    ? 0
                    : 1,
                onValueChanged: (int newValue) {
                  setState(() {
                    widget._controller.temperatureUnit = newValue == 0
                        ? TemperatureUnit.Celcius
                        : TemperatureUnit.Fahrenheit;
                  });
                },
              ),
              ForecastRow(data: forecastWeatherController.getHourlyForcast()),
              DetailsCard(
                title: 'Weather Details',
                data: currentWeatherController.weatherDetails,
              ),
              DetailsCard(
                title: 'Sun & Moon',
                data: forecastWeatherController.astroDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
