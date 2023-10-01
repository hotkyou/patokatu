import 'package:flutter/material.dart';

class PointPage extends StatelessWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ポイント')),
      body: const Center(
        child: Text('0ポイント'),
      ),
    );
  }
}
