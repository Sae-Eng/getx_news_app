import 'package:flutter_test/flutter_test.dart';
import 'package:getx_news_app/api/news_api_client.dart';
import 'package:getx_news_app/repository/news_repository.dart';
import 'package:mockito/mockito.dart';

// NewsApiClientをモック化するクラス
class MockNewsApiClient extends Mock implements NewsApiClient {
  @override
  Future<List<dynamic>> fetchTopHeadlines() async {
    return [
      {
        "source": {"id": "google-news", "name": "Google News"},
        "author": "nhk.or.jp",
        "title": "G7農相会合始まる 食料安全保障の強化 一致できるか焦点 - nhk.or.jp",
        "description": null,
        "url":
            "https://news.google.com/rss/articles/CBMiPmh0dHBzOi8vd3d3My5uaGsub3IuanAvbmV3cy9odG1sLzIwMjMwNDIyL2sxMDAxNDA0NTk0MTAwMC5odG1s0gFCaHR0cHM6Ly93d3czLm5oay5vci5qcC9uZXdzL2h0bWwvMjAyMzA0MjIvYW1wL2sxMDAxNDA0NTk0MTAwMC5odG1s?oc=5",
        "urlToImage": null,
        "publishedAt": "2023-04-22T06:24:29Z",
        "content": null
      },
    ];
  }
}

void main() {
  late NewsRepository newsRepository;
  late NewsApiClient apiClient;

  setUp(() {
    apiClient = MockNewsApiClient();
    newsRepository = NewsRepository(apiClient: apiClient);
  });

  // fetchTopHeadlinesが記事のリストを返すことをテストします。
  test('fetchTopHeadlines returns a list of articles', () async {
    final result = await newsRepository.getTopHeadlines();
    expect(result, isNotNull);
    expect(result, isA<List<dynamic>>());
    expect(result.length, 1);
    expect(result[0]['title'], 'G7農相会合始まる 食料安全保障の強化 一致できるか焦点 - nhk.or.jp');
    expect(result[0]['description'], null);
  });
}
