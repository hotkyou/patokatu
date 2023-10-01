import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart'; // LINE SDK追加
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:cloud_functions/cloud_functions.dart';

final authManagerProvider = ChangeNotifierProvider<AuthManager>(
  (ref) {
    return AuthManager();
  },
);

class AuthManager with ChangeNotifier {
  AuthManager() {
    _firebaseAuth.authStateChanges().listen((user) {
      isLoggedIn = user != null;
      notifyListeners();
    });
  }

  void registerDB(lineUserID) async {
    await dotenv.load(fileName: '.env');
    String apiUrl = dotenv.get('cybozeURL');
    final Map<String, dynamic> data = {
      'app': 1,
      'record': {
        'Line_ID': {
          'value': lineUserID,
        },
        'Point': {
          'value': '0',
        },
      }
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "X-Cybozu-API-Token": dotenv.get('cybozeAPI'),
    };

    http.Response response = await http.post(
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

  final _firebaseAuth = FirebaseAuth.instance;
  final _lineSdk = LineSDK.instance; // LINE SDKのインスタンス
  bool isLoggedIn = false;
  // ログイン処理
  Future<void> signInWithLine() async {
    // LINEログインし、LINEのuserIdを取得する
    final result = await _lineSdk.login();
    final lineUserID = result.userProfile?.userId;

    registerDB(lineUserID);

    // // LINEのuserIdを使って、Cloud Functionsからカスタムトークンを取得する
    // final callable = FirebaseFunctions.instanceFor(region: 'asia-northeast1')
    //     .httpsCallable('fetchCustomToken');
    // final response = await callable.call({
    //   'userId': lineUserId,
    // });

    // // functionsから取得したカスタムトークンを使用して、Firebaseログイン
    // await _firebaseAuth.signInWithCustomToken(response.data['customToken']);
  }

  // ログアウト処理
  Future<void> signOut() async {
    // LINE, Firebase両方でログアウトする
    await _lineSdk.logout();
    await _firebaseAuth.signOut();
  }
}
