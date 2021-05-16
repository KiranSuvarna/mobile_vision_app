import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'pages/imageViewer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  await DotEnv.load(fileName: ".env");
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Screen",
      home: PickImage(),
    );
  }
}

class PickImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PickImageState();
}

class PickImageState extends State<PickImage> {
  File _image;
  ImagePicker _imagePicker = new ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    splashColor: Colors.white.withAlpha(100),
                    onTap: () async {
                      try {
                        PickedFile pickedFile = await _imagePicker.getImage(
                            source: ImageSource.gallery);
                        _image = File(pickedFile.path);
                        if (_image != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                image: _image,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        throw Exception(
                            "Failed to pick the file. Reason" + e.toString());
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
                  ListTile(
                    leading: Icon(
                      Icons.upload_file,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Tap to select an Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.blue,
              elevation: 10.0,
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.grey.withAlpha(100),
                    onTap: () async {
                      try {
                        PickedFile pickedFile = await _imagePicker.getImage(
                            source: ImageSource.camera);
                        _image = File(pickedFile.path);
                        if (_image != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                image: _image,
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
                        child:
                            Icon(Icons.camera, size: 75.0, color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.camera, color: Colors.white),
                    title: Text(
                      'Tap to capture an Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
