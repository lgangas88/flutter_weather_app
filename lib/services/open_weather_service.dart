import 'package:flutter_news_app/models/open_weather_response.dart';
import 'package:flutter_news_app/services/dio_service.dart';
import 'package:flutter_news_app/utils/api_endpoints.dart';

class OpenWeatherService {
  final DioService dioService;

  OpenWeatherService({required this.dioService});

  Future<OpenWeatherResponse> getWeather(double lat, double lon) async {
    final response = await dioService.openWeatherApiInstance.get(
      ApiEndpoints.getWeather,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'units': 'metric',
      },
    );

    return OpenWeatherResponse.fromJson(response.data);
  }
}
