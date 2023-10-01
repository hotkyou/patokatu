import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  final String imagePath;

  void sendLineMessage() async {
    await dotenv.load(fileName: '.env');
    final String apiUrl = dotenv.get('lineURL');
    final String channelAccessToken = dotenv.get('lineChannelAccessToken');
    final Map<String, dynamic> data = {
      'to': dotenv.get('lineTo'),
      'messages': [
        {
          'type': 'image',
          "originalContentUrl":
              "https://cdn.discordapp.com/attachments/1103161479651414056/1157889603227877466/IMG_2994.jpg?ex=651a4039&is=6518eeb9&hm=0e6e403454fe8f324d5c7cbf724358d89db1a32be6704d7f5454b7e04e67ef26&",
          "previewImageUrl":
              "https://cdn.discordapp.com/attachments/1103161479651414056/1157889603227877466/IMG_2994.jpg?ex=651a4039&is=6518eeb9&hm=0e6e403454fe8f324d5c7cbf724358d89db1a32be6704d7f5454b7e04e67ef26&"
        },
      ],
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $channelAccessToken',
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully.');
    } else {
      print('Error sending message: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

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
            TextButton(
                onPressed: () {
                  sendLineMessage();
                },
                child: const Text("投稿")),
          ],
        ),
      ),
    );
  }
}
