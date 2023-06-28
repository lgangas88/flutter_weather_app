import 'package:flutter_news_app/models/everything_response.dart';
import 'package:flutter_news_app/services/dio_service.dart';
import 'package:flutter_news_app/utils/api_endpoints.dart';

class NewsService {
  NewsService({required this.dioService});

  final DioService dioService;

  Future<EverythingResponse> getNews({
    String query = '',
    int pageSize = 10,
    int page = 1,
  }) async {
    final response = await dioService.newsApiInstance.get(
      ApiEndpoints.getNews,
      queryParameters: {
        'q': query,
        'pageSize': pageSize,
        'page': page,
        'language': 'en',
      },
    );

    return EverythingResponse.fromJson(response.data);
  }
}
