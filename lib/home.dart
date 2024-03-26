// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     late File _image;
//     List _output;
//     final picker = ImagePicker();

//     @override
//     void initState() {
//       super.initState();
//       loadModel().then((value) {
//         setState(() {});
//       });
//     }

//     detectImage(File image) async {
//       var output = await Tflite.runModelOnImage(
//           path: image.path,
//           numResults: 2,
//           threshold: 0.6,
//           imageMean: 127.5,
//           imageStd: 127.5);
//       setState(() {
//         _output = output;
//       });
//     }

//     loadModel() async {
//       await Tflite.loadModel(
//           model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
//     }

//     @override
//     void dispose() {
//       super.dispose();
//     }

//     pickImage() async {
//       var image = await picker.getImage(source: ImageSource.camera);
//       if (image == null) return null;
//       setState(() {
//         _image = File(image.path);
//       });
//       detectImage(_image);
//     }

//    Future<void> pickGallery() async {
//       final image = await picker.getImage(source: ImageSource.gallery);
//       if (image == null) return null;
//       setState(() {
//         _image = File(image.path);
//       });
//       detectImage(_image);
//     }

//     return Scaffold(
//         backgroundColor: Colors.blueAccent,
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 50),
//               const Text(
//                 "Coding Cafe",
//                 style: TextStyle(color: Color(0x007d9e9e), fontSize: 20),
//               ),
//               const SizedBox(height: 5),
//               const Center(
//                 child: Text(
//                   "Cats and Dogs Detector App",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontFamily: 'Aerial',
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Center(
//                   child: Container(
//                 width: 400,
//                 child: Column(
//                   children: [
//                     Image.asset("assets/images/c.png"),
//                     const SizedBox(height: 50),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 250,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 25, vertical: 18),
//                         decoration: BoxDecoration(
//                             color: Colors.green[400],
//                             borderRadius: BorderRadius.circular(6)),
//                         child: const Text(
//                           "Capture a Photo",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 250,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 25, vertical: 18),
//                         decoration: BoxDecoration(
//                             color: Colors.green[400],
//                             borderRadius: BorderRadius.circular(6)),
//                         child: const Text(
//                           "Select a Photo",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // ignore: dead_code
//               ))
//             ],
//           ),
//         ));
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart'; 

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late File _image;
 late  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await FlutterTflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
    });
  }

  loadModel() async {
    await FlutterTflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickImage() async {
    final image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  Future<void> pickGallery() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              "Coding Cafe",
              style: TextStyle(color: Color(0x007d9e9e), fontSize: 20),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                "Cats and Dogs Detector App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Aerial',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 400,
                child: Column(
                  children: [
                    Image.asset("assets/images/c.png"),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 250,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 18),
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          "Capture a Photo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: pickGallery,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 250,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 18),
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          "Select a Photo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
