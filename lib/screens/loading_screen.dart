import 'package:clima/models/weather_data.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  final String locationName;

  const LoadingScreen({this.locationName = ''});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    try {
      var weatherService = WeatherService();
      WeatherData data = widget.locationName.isEmpty
          ? await WeatherService().getCurrentLocationWeather()
          : await weatherService.getNameLocationWeather(
              name: widget.locationName,
            );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(data: data);
          },
        ),
      );
    } on LocationServiceException catch (e) {
      AppDialogs dialog = AppDialogs(
        onTap: () {
          getLocationData();
        },
      );
      dialog.locationServiceErrorDialog(context, e.message);
    } on ClientException catch (e) {
      AppDialogs dialog = AppDialogs(
        onTap: () {
          getLocationData();
        },
      );
      dialog.clientExceptionDialog(
        context,
        'Could not connect to the server ${e.message}',
      );
    } catch (e) {
      AppDialogs dialog = AppDialogs(
        onTap: () {
          getLocationData();
        },
      );
      dialog.generalErrorDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Lottie.asset('lottie/loading.json')));
  }
}
