import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../camera/camera.dart';
import '../authmanage.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  _request(userid) {
    Uri url = Uri.parse("https://api.line.me/v2/bot/message/push");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer {access_token}',
      'X-Line-Retry-Key': ''
    };
    String body = json.encode({'userid': 'moke', 'explain': '', 'image': ''});
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
