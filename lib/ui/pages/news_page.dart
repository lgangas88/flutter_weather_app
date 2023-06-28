import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/city.dart';
import 'package:flutter_news_app/ui/pages/news_detail_page.dart';
import 'package:flutter_news_app/ui/providers/news_provider.dart';
import 'package:flutter_news_app/utils/constants.dart';
import 'package:flutter_news_app/utils/functions.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  static const pageName = '/news_page';

  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'News App',
        ),
        titleTextStyle: textTheme.headlineSmall!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
        actions: [
          if (newsProvider.city.weather != null)
            Row(
              children: [
                Text(
                  newsProvider.city.shortName,
                  style: textTheme.bodyMedium!.copyWith(color: Colors.blue),
                ),
                const SizedBox(width: 8),
                Text(
                  '°C${newsProvider.city.temperature?.temp?.toString() ?? ''}',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                Image.network(getWeatherIcon(newsProvider.city.weather!.icon!)),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final city = await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: cities.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return TextButton(
                    onPressed: () => Navigator.pop(context, city),
                    child: Text(city.name),
                  );
                },
              );
            },
          );

          if (city is City) {
            newsProvider.setCity(city);
          }
        },
        child: const Icon(
          Icons.location_city_rounded,
        ),
      ),
      body: ListView.separated(
        itemCount: newsProvider.articles.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final article = newsProvider.articles[index];

          if (index == newsProvider.articles.length - 3) {
            newsProvider.getNews();
          }

          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              NewsDetailPage.pageName,
              arguments: article,
            ),
            child: Column(
              children: [
                article.urlToImage != null
                    ? CachedNetworkImage(
                        height: 190,
                        width: double.infinity,
                        imageUrl: article.urlToImage ?? '',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 190,
                        color: Colors.grey.shade300,
                        child: const Placeholder(),
                      ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? '',
                        style: textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.description ?? '',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
