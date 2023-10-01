import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撮れた写真')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 40, left: 40, bottom: 10),
                child: Image.file(File(imagePath))),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '概要',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'タグ',
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("投稿")),
          ],
        ),
      ),
    );
  }
}
