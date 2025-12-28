import 'package:news_app/core/api/api_client.dart';
import 'package:news_app/core/api/api_endpoints.dart';
import 'package:news_app/features/news/data/models/article.dart';

class NewsRepository {
  final ApiClient apiClient;

  NewsRepository(this.apiClient);

  /// CATEGORY / TOP HEADLINES
  Future<List<ArticleModel>> fetchNews({
    required String category,
    required int page,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.topHeadlines,
      query: {
        'apiKey': ApiEndpoints.apiKey,
        'country': 'us',
        'category': category,
        'page': page,
        'pageSize': 20,
      },
    );

    final List articles = response.data['articles'] ?? [];

    return articles
        .map((e) => ArticleModel.fromJson(e))
        .toList();
  }

  /// SEARCH NEWS
  Future<List<ArticleModel>> searchNews({
    required String query,
    required int page,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.everything,
      query: {
        'apiKey': ApiEndpoints.apiKey,
        'q': query,
        'sortBy': 'publishedAt',
        'language': 'en',
        'page': page,
        'pageSize': 20,
      },
    );

    final List articles = response.data['articles'] ?? [];

    return articles
        .map((e) => ArticleModel.fromJson(e))
        .toList();
  }
}
