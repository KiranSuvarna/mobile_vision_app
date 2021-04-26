import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_vision/pages/responseViewer.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:path/path.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Image.file(File(imagePath),
                width: double.infinity, height: 500, fit: BoxFit.contain),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _sendRequest(imagePath, context),
        label: const Text("Upload"),
        icon: Icon(Icons.upload_file),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

Future<String> _sendRequest(String imagePath, BuildContext context) {
  try {
    var request = MultipartRequest();
    request.setUrl("https://api.imgur.com/3/image");
    request.addHeader("Authorization", "Client-ID 0efd961ac3ccb75");
    request.addFile("image", imagePath);

    Response response = request.send();

    response.onError = (error) {
      return error;
    };

    response.onComplete = (response) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResponseViewer(response: response)),
      );
    };

    response.progress.listen((event) {
      print("Progress from response object " + event.toString());
    });
  } catch (e) {
    throw Exception("Faile to upload the image. Reason" + e.toString());
  }
}
