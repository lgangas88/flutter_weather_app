import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_news_app/models/everything_response.dart';
import 'package:flutter_news_app/services/dio_service.dart';
import 'package:flutter_news_app/services/news_service.dart';
import 'package:flutter_news_app/services/open_weather_service.dart';
import 'package:flutter_news_app/ui/pages/news_detail_page.dart';
import 'package:flutter_news_app/ui/pages/news_page.dart';
import 'package:flutter_news_app/ui/providers/news_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => DioService(),
        ),
        Provider(
          create: (context) => NewsService(
            dioService: context.read<DioService>(),
          ),
        ),
        Provider(
          create: (context) => OpenWeatherService(
            dioService: context.read<DioService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(
            newsService: context.read<NewsService>(),
            weatherService: context.read<OpenWeatherService>(),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: NewsPage.pageName,
        routes: {
          NewsPage.pageName: (context) => const NewsPage(),
          NewsDetailPage.pageName: (context) {
            final article =
                ModalRoute.of(context)?.settings.arguments as Article;
            return NewsDetailPage(
              article: article,
            );
          },
        },
      ),
    );
  }
}
