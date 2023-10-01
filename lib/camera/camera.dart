import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';

import '../authmanage.dart';
import 'camerapreview.dart';
import '../screens/point.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras.first, ResolutionPreset.high);
    await cameraController.initialize();
    setState(() {
      isCameraInitialized = true; // カメラの初期化が完了したことをマーク
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("カメラ"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PointPage()));
              },
              child: const Text("0Points"))
        ],
      ),
      body: CameraPreview(cameraController),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final image = await cameraController.takePicture();
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: image.path),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
