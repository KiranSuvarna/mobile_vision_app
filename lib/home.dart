import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_vision/pages/camera.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  final ThemeData _theme = _buildTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Screen",
      theme: _theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mobile Vision"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () => _initCamera(context),
                child: Text("Open Camera")),
          ]),
        ),
      ),
    );
  }
}

Future<void> _initCamera(BuildContext context) async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

ThemeData _buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    primaryTextTheme: Typography.blackMountainView,
    primaryIconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    accentColor: Colors.green[800],
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: Colors.green[800],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
