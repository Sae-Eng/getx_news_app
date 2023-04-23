import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class NewsApiClient {
  final String _apiKey = FlutterConfig.get('API_KEY'); // APIキーを取得

  Future<List<dynamic>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=jp&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
