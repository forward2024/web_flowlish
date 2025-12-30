import 'package:flutter/material.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новини Flowlish')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('Тут буде ваша стрічка новин або блог...'),
        ),
      ),
    );
  }
}
