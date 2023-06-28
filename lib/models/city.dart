import 'package:flutter_news_app/models/open_weather_response.dart';

class City {
  final String name;
  final String shortName;
  final double latitude;
  final double longitude;
  Weather? weather;
  Main? temperature;

  City({
    required this.name,
    required this.shortName,
    required this.latitude,
    required this.longitude,
  });
}
