import 'package:getx_news_app/api/news_api_client.dart';

class NewsRepository {
  final NewsApiClient apiClient;

  NewsRepository({required this.apiClient});

  Future<List<dynamic>> getTopHeadlines() async {
    return await apiClient.fetchTopHeadlines();
  }
}
