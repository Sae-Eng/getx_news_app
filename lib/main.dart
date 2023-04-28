import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:getx_news_app/view/news_page.dart';

import 'api/news_api_client.dart';
import 'repository/news_repository.dart';
import 'vm/news_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 初期バインディングを設定
      initialBinding: BindingsBuilder(() {
        Get.put(NewsApiClient());
        Get.put(NewsRepository(apiClient: Get.find()));
        Get.put(NewsViewModel(repository: Get.find()));
      }),
      home: const NewsPage(),
    );
  }
}
