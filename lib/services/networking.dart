import 'dart:async';
import 'dart:io';

import 'package:clima/secrets.dart';
import 'package:http/http.dart';

class NetworkHelper {
  final Uri uri;

  NetworkHelper({required this.uri});

  Future<String> getData() async {
    print('Get: $uri');
    try {
      Response response = await get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ClientException(
          'Error: $uri resulted in ${response.statusCode} with ${response.reasonPhrase}',
          uri,
        );
      }
    } on SocketException catch (e) {
      throw ClientException('Network error while reaching $uri: $e');
    } on HttpException catch (e) {
      throw ClientException('HTTP error while reaching $uri: $e');
    } on FormatException catch (e) {
      throw ClientException('Invalid response format from $uri: $e');
    } on TimeoutException catch (e) {
      throw ClientException('Timed out while reaching $uri: $e');
    }
  }
}

class ApiHelper {
  Uri forcastDataUriByLocation({
    required double latitude,
    required double longitude,
  }) => Uri(
    scheme: 'https',
    host: 'api.weatherapi.com',
    path: 'v1/forecast.json',
    queryParameters: {
      'key': Secrets.weatherApiKey,
      'q': [latitude.toString(), longitude.toString()],
      'days': '1',
      'aqi': 'no',
      'alerts': 'no',
    },
  );

  Uri forcastDataUriByName({required String name}) => Uri(
    scheme: 'https',
    host: 'api.weatherapi.com',
    path: 'v1/forecast.json',
    queryParameters: {
      'key': Secrets.weatherApiKey,
      'q': name,
      'days': '1',
      'aqi': 'no',
      'alerts': 'no',
    },
  );
}
