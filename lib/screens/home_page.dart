import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Detector'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.camera_alt),
      ),
      body: GetBuilder<HomeController>(
        init: _homeController,
        initState: (_) async {
          await _homeController.loadCamera();
          _homeController.startImageStream();
        },
        builder: (_) {
          return Column(
            children: [
              _.cameraController != null &&
                      _.cameraController!.value.isInitialized
                  ? Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CameraPreview(_.cameraController!))
                  : const Center(child: Text('loading')),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 200,
                  height: 200,
                  color: Colors.white,
                  child: Image.asset(
                    'images/${_.faceAtMoment}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                '${_.label}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
