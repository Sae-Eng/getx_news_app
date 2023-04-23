import 'package:get/get.dart';

import '../repository/news_repository.dart';

/// ニュース一覧 ViewObject
class ArticleViewObject {
  final String title;
  final Uri url;

  ArticleViewObject({required this.title, required this.url});
}

class NewsViewModel extends GetxController {
  final NewsRepository repository;
  var articles = <ArticleViewObject>[].obs;
  var errorMessage = ''.obs;
  var hasError = false.obs;

  NewsViewModel({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  void fetchTopHeadlines() async {
    try {
      List<dynamic> rawArticles = await repository.getTopHeadlines();
      articles.value = rawArticles
          .map((article) => ArticleViewObject(
                title: article['title'],
                url: Uri.parse(article['url']),
              ))
          .toList();
      hasError.value = false;
      errorMessage.value = '';
    } catch (e) {
      hasError.value = true;
      errorMessage.value = '記事の取得に失敗しました。';
    }
  }
}
