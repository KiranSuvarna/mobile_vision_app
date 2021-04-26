import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'pages/imageViewer.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Screen",
      //theme: _theme,
      home: PickImage(),
    );
  }
}

class PickImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PickImageState();
}

class PickImageState extends State<PickImage> {
  String _imagePath = "";
  ImagePicker _imagePicker = new ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Vision"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.blue,
              elevation: 10.0,
              child: InkWell(
                splashColor: Colors.grey.withAlpha(100),
                onTap: () async {
                  try {
                    PickedFile pickedFile = await _imagePicker.getImage(
                        source: ImageSource.gallery);
                    _imagePath = File(pickedFile.path).path;
                    if (_imagePath != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            imagePath: _imagePath,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const SizedBox(
                  width: 400,
                  height: 200,
                  child: Center(
                    child: Icon(Icons.file_upload,
                        size: 75.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.blue,
              elevation: 10.0,
              child: InkWell(
                splashColor: Colors.grey.withAlpha(100),
                onTap: () async {
                  try {
                    PickedFile pickedFile =
                        await _imagePicker.getImage(source: ImageSource.camera);
                    _imagePath = File(pickedFile.path).path;
                    if (_imagePath != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            imagePath: _imagePath,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const SizedBox(
                  width: 400,
                  height: 200,
                  child: Center(
                    child: Icon(Icons.camera, size: 75.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> _initCamera(BuildContext context) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   return MaterialApp(
//     theme: ThemeData.dark(),
//     home: TakePictureScreen(
//       // Pass the appropriate camera to the TakePictureScreen widget.
//       camera: firstCamera,
//     ),
//   );
// }
