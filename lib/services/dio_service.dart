import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  final newsApiInstance = Dio(
    BaseOptions(
      baseUrl: dotenv.env['NEWS_API_URL'] ?? '',
      queryParameters: {
        'apiKey': dotenv.env['NEWS_API_KEY'] ?? '',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) => handler.next(e),
      ),
    );

  final openWeatherApiInstance = Dio(
    BaseOptions(
      baseUrl: dotenv.env['OPEN_WEATHER_API_URL'] ?? '',
      queryParameters: {
        'appid': dotenv.env['OPEN_WEATHER_API_KEY'] ?? '',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) => handler.next(e),
      ),
    );
}
