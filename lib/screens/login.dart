import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../camera/camera.dart';
import '../authmanage.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  void sendLineMessage() async {
    await dotenv.load(fileName: '.env');
    String apiUrl = dotenv.get('lineURL');
    String channelAccessToken = dotenv.get('lineChannelAccessToken');

    final Map<String, dynamic> data = {
      'to': dotenv.get('lineTo'),
      'messages': [
        {
          'type': 'text',
          'text': 'Hello, world1',
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 96),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("img/patokatu.jpg"),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: ElevatedButton(
                onPressed: () => {
                  sendLineMessage(),
                  ref.watch(authManagerProvider.notifier).signInWithLine(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CameraPage())),
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(6, 199, 85, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                child: Row(
                  children: [
                    Image.asset("img/line_logo.png"),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "LINE LOGIN",
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
