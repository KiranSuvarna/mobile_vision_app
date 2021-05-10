import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_vision/pages/responseIndex.dart';

class DisplayPictureScreen extends StatefulWidget {
  final File image;

  const DisplayPictureScreen({Key key, this.image}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.file(widget.image, fit: BoxFit.contain),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResponseIndex(
                  image: widget.image,
                ),
              ))
        },
        //_sendRequest(widget.imagePath, context),
        label: const Text("Upload"),
        icon: Icon(Icons.upload_file),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
