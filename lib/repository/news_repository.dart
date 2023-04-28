import 'package:getx_news_app/api/news_api_client.dart';

/// このクラスは、APIクライアントを通じてニュースデータを取得し、ビジネスロジックを適用します。
class NewsRepository {
  // News APIクライアントのインスタンス
  final NewsApiClient apiClient;

  /// NewsRepositoryクラスのコンストラクタ
  ///
  /// [apiClient] は、ニュースデータを取得するために使用されるNewsApiClientインスタンスです。
  NewsRepository({required this.apiClient});

  /// トップニュースの一覧を取得するメソッド
  ///
  /// このメソッドは、[apiClient]を使用してトップニュースの一覧を取得し、そのデータを返します。
  Future<List<dynamic>> getTopHeadlines() async {
    // NewsApiClientのfetchTopHeadlinesメソッドを呼び出し、ニュースデータを取得
    return await apiClient.fetchTopHeadlines();
  }
}
