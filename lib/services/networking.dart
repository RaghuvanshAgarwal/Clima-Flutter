import 'package:clima/secrets.dart';
import 'package:http/http.dart';

class NetworkHelper {
  final Uri uri;

  NetworkHelper({required this.uri});

  Future<String> getData() async {
    print('Get: $uri');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Future.error(
        'Error: $uri resulted in ${response.statusCode} with ${response.reasonPhrase}',
      );
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
