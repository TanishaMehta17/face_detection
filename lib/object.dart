import 'package:camera/camera.dart';
import 'package:face_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home1 extends StatefulWidget {
  static const routeName = "/object";
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  bool isWorking = false;
  String result = "";
  late CameraController cameraController;
  CameraImage? imgCamera;

  initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    cameraController.startImageStream((imagesFromStream) {
      if (!isWorking) {
        setState(() {
          isWorking = true;
          imgCamera = imagesFromStream;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/jaris.jpg")),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  // Center(
                  //   child: Container(
                  //     color: Colors.black,
                  //     height: 320,
                  //     width: 360,
                  //     child: Image.network(
                  //         "https://www.nj.com/resizer/HFZn9c0uJ1jvrFL7O2qwpHWgK84=/700x0/smart/arc-anglerfish-arc2-prod-advancelocal.s3.amazonaws.com/public/2QZXPRWROJEOJHKXDRB2S4YVFY.JPG"),
                  //   ),
                  // ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      initCamera();
                    },
                    child: Container(
                      //margin: const EdgeInsets.only(top: 35),
                      // height: 270,
                      // width: 360,
                      child: imgCamera == null
                          ? Icon(Icons.photo_camera_front,
                              color: Colors.blueAccent, size: 40)
                          : AspectRatio(
                              aspectRatio: cameraController.value.aspectRatio,
                              child: CameraPreview(cameraController),
                            ),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
