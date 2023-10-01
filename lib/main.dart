import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/login.dart';
import 'camera/camera.dart';
import 'authmanage.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // firebaseの初期化
  // ↓に先ほど作成したチャンネルのチャンネルIDを入れる(String)
  await LineSDK.instance.setup(dotenv.get('LINE_CHANNEL_ID'));
  runApp(
    // riverpod用の記述
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authManager = ref.watch(authManagerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'タイトル',
      // ログイン中：ホーム画面、未ログイン：ログイン画面
      home: authManager.isLoggedIn ? const CameraPage() : const Login(),
    );
  }
}