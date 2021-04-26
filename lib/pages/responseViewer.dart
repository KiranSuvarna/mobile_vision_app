import 'package:flutter/material.dart';

class ResponseViewer extends StatefulWidget {
  final String response;

  const ResponseViewer({
    Key key,
    @required this.response,
  }) : super(key: key);

  @override
  _ResponseViewerState createState() => _ResponseViewerState();
}

class _ResponseViewerState extends State<ResponseViewer> {
  String res;

  @override
  void initState() {
    super.initState();
    res = widget.response;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Screen",
      //theme: _theme,
      home: Scaffold(
        appBar: AppBar(title: Text("test")),
        body: Container(
          child: Center(child: Text(res)),
        ),
      ),
    );
  }
}
