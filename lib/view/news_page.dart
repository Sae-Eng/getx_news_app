import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../vm/news_view_model.dart';
import 'error_state_widget.dart';

/// ニュース記事一覧ページを表示するウィジェット
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  // URLを開くヘルパーメソッド
  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<NewsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('GetX News')),
      body: Obx(() {
        // エラー表示
        if (viewModel.hasError.value) {
          return ErrorStateWidget(
            errorMessage: viewModel.errorMessage.value,
            retryCallback: viewModel.fetchTopHeadlines,
          );
        }
        // 読み込み中
        else if (viewModel.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        // コンテンツを表示
        else {
          return ListView.separated(
            itemCount: viewModel.articles.length,
            itemBuilder: (context, index) {
              final article = viewModel.articles[index];
              return ListTile(
                title: Text(article.title),
                onTap: () => _launchURL(article.url),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 20,
                color: Colors.grey,
              );
            },
          );
        }
      }),
      // リフレッシュボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchTopHeadlines(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
