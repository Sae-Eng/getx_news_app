import 'package:get/get.dart';

import '../repository/news_repository.dart';

/// ニュース一覧 ViewObject
///
/// [title]と[url]のみを含むView用のデータクラス
class ArticleViewObject {
  final String title;
  final Uri url;

  /// ArticleViewObjectのコンストラクタ
  ///
  /// [title]はニュースのタイトル、[url]はニュースのURL
  ArticleViewObject({required this.title, required this.url});
}

/// ニュースのViewModelクラス
///
/// このクラスは、ニュースリポジトリを利用してデータを取得し、Viewで表示するために加工します。
class NewsViewModel extends GetxController {
  final NewsRepository repository;
  var articles = <ArticleViewObject>[].obs;
  var errorMessage = ''.obs;
  var hasError = false.obs;

  /// NewsViewModelクラスのコンストラクタ
  ///
  /// [repository]は、ニュースデータを取得するためのNewsRepositoryインスタンス
  NewsViewModel({required this.repository});

  /// ViewModelが初期化されるときに実行されるメソッド
  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines(); // 初期化時にトップニュースを取得
  }

  /// トップニュースを取得し、Viewで表示できる形に加工するメソッド
  void fetchTopHeadlines() async {
    try {
      // リポジトリから生の記事データを取得
      List<dynamic> rawArticles = await repository.getTopHeadlines();

      // 生の記事データをArticleViewObjectのリストに変換
      articles.value = rawArticles
          .map((article) => ArticleViewObject(
                title: article['title'],
                url: Uri.parse(article['url']),
              ))
          .toList();

      // エラー表示をリセット
      hasError.value = false;
      errorMessage.value = '';
    } catch (e) {
      // 記事取得に失敗した場合、エラー表示を更新
      hasError.value = true;
      errorMessage.value = '記事の取得に失敗しました。';
    }
  }
}
