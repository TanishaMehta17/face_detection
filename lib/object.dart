import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Home1 extends StatefulWidget {
  static const routeName = "/object";
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  bool isWorking = false;
  String result = "";
  late CameraController cameraController;
  CameraImage? imgCamera;

  @override
  void initState() {
    super.initState();
    isWorking = false;
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController.dispose();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/mobilenet_v1_1.0_224.txt",
    );
  }

  initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    cameraController.startImageStream((imagesFromStream) {
      if (!isWorking) {
        setState(() {
          isWorking = true;
          imgCamera = imagesFromStream;
          runModelFromStreamFrames();
        });
      }
    });
  }

  runModelFromStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognitions?.forEach((respone) {
        result += respone["label"] +
            "  " +
            (respone["confidence"] as double).toStringAsFixed(2) +
            "\n\n";
      });
      setState(() {
        result;
      });
      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/jaris.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          initCamera();
                        },
                        child: Container(
                          child: imgCamera == null
                              ? const Icon(Icons.photo_camera_front,
                                  color: Colors.blueAccent, size: 40)
                              : AspectRatio(
                                  aspectRatio:
                                      cameraController.value.aspectRatio,
                                  child: CameraPreview(cameraController),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              , Center(
                child: Container(
                  margin: const EdgeInsets.only(top:55.0),
                  child: SingleChildScrollView(
                    child: Text(
                      textAlign: TextAlign.center,
                      result,style:const TextStyle(backgroundColor: Colors.black87,fontSize: 30.0,color: Colors.white),),
                  ),
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
