import 'package:flutter/material.dart';

/// エラー状態を表示するウィジェット
class ErrorStateWidget extends StatelessWidget {
  // 表示するエラーメッセージ
  final String errorMessage;
  // リトライボタンが押されたときのコールバック
  final VoidCallback retryCallback;

  // コンストラクタ
  const ErrorStateWidget({super.key, required this.errorMessage, required this.retryCallback});

  @override
  Widget build(BuildContext context) {
    // エラーメッセージとリトライボタンを含むウィジェットを返す
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: retryCallback,
            child: const Text('リトライ'),
          ),
        ],
      ),
    );
  }
}
