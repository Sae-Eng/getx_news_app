import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

/// News APIのクライアントを提供するクラス
///
/// このクラスは、News APIからデータを取得するためのhttpリクエストを処理します。
class NewsApiClient {
  // APIキーを取得
  final String _apiKey = FlutterConfig.get('API_KEY');

  /// トップニュースの一覧を取得するメソッド
  ///
  /// このメソッドは、News APIからトップニュースの一覧を取得し、JSON形式のデータを返します。
  /// 例外が発生した場合、エラーメッセージを投げます。
  Future<List<dynamic>> fetchTopHeadlines() async {
    // News APIのエンドポイントにGETリクエストを送信
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=jp&apiKey=$_apiKey'),
    );

    // ステータスコードが200(成功)の場合、JSON形式の記事リストを返す
    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      // ステータスコードが200以外の場合、例外を投げる
      throw Exception('Failed to load news');
    }
  }
}
