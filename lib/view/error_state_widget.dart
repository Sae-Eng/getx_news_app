import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback retryCallback;

  const ErrorStateWidget({super.key, required this.errorMessage, required this.retryCallback});

  @override
  Widget build(BuildContext context) {
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
