import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/everything_response.dart';

class NewsDetailPage extends StatelessWidget {
  static const pageName = '/news_detail_page';

  const NewsDetailPage({
    required this.article,
    super.key,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 190,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: article.urlToImage != null
                  ? CachedNetworkImage(
                      height: 190,
                      width: double.infinity,
                      imageUrl: article.urlToImage ?? '',
                      colorBlendMode: BlendMode.saturation,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 190,
                      color: Colors.grey.shade300,
                      child: const Placeholder(),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? '',
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.source.name ?? '',
                        style: textTheme.labelSmall,
                      ),
                      Text(
                        article.formattedPublishedAt,
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.description ?? '',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  Html(
                    data: article.content ?? '',
                    style: {
                      '*': Style(
                        margin: EdgeInsets.zero,
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
