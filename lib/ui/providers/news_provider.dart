import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/city.dart';
import 'package:flutter_news_app/models/everything_response.dart';
import 'package:flutter_news_app/services/news_service.dart';
import 'package:flutter_news_app/services/open_weather_service.dart';
import 'package:flutter_news_app/utils/constants.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService newsService;
  final OpenWeatherService weatherService;

  NewsProvider({
    required this.newsService,
    required this.weatherService,
  });

  List<Article> articles = [];
  int _page = 1;
  City city = cities.first;

  void init() {
    getNews();
    getWeather();
  }

  void getNews() async {
    try {
      final everythingResponse = await newsService.getNews(
        query: city.name,
        page: _page,
      );
      articles.addAll(everythingResponse.articles);
      notifyListeners();
      _page++;
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  void setCity(City city) {
    this.city = city;
    articles.clear();
    getNews();
    getWeather();
  }

  void getWeather() async {
    try {
      final openWeatherResponse = await weatherService.getWeather(
        city.latitude,
        city.longitude,
      );
      city.weather = openWeatherResponse.mainWeather;
      city.temperature = openWeatherResponse.main;
      notifyListeners();
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
