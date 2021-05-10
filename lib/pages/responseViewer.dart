import 'package:flutter/material.dart';

class ResponseViewer extends StatefulWidget {
  final String label;
  final String data;
  final IconData icon;

  const ResponseViewer(
      {Key key, @required this.label, @required this.data, @required this.icon})
      : super(key: key);

  @override
  _ResponseViewerState createState() => _ResponseViewerState();
}

class _ResponseViewerState extends State<ResponseViewer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Response Viewer",
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50.0),
          child: ListTile(
            leading: Icon(widget.icon),
            title: Text(widget.label),
            subtitle: Text(
              widget.data,
              overflow: TextOverflow.fade,
              maxLines: 50,
            ),
          ),
        ),
      ),
    );
  }
}
