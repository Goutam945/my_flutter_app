import 'package:dio/dio.dart';
import '../model/news_article.dart';

class NewsRepository {
  final Dio _dio = Dio();
  final String _apiKey = '7344398127f7442f8449d8dc2d6dcd34';

  Future<List<NewsArticle>> fetchNews(String query, int page) async {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': query,
          'apiKey': _apiKey,
          'page': page,
          'pageSize': 20,
        },
      );

      final articles = response.data['articles'] as List;
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
