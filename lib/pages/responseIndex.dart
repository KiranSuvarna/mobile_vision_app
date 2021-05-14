import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';
import 'dart:convert';

import 'package:mobile_vision/models/common.dart';
import 'package:mobile_vision/pages/responseViewer.dart';

class ResponseIndex extends StatefulWidget {
  final File image;

  const ResponseIndex({Key key, @required this.image}) : super(key: key);

  @override
  _ResponseIndexState createState() => _ResponseIndexState();
}

class _ResponseIndexState extends State<ResponseIndex> {
  String imagePath;

  Future<String> _sendRequest(File image) async {
    try {
      var stream = new http.ByteStream(DelegatingStream(image.openRead()));

      int length = await image.length();

      var uri = Uri.parse("https://a1a0aebfa9a7.ngrok.io/v1?op=vision");

      var request = new http.MultipartRequest("POST", uri);

      var multipartFile =
          new http.MultipartFile('Image', stream, length, filename: image.path);
      request.files.add(multipartFile);

      http.Response response =
          await http.Response.fromStream(await request.send());

      return response.body;
    } catch (e) {
      throw Exception("Failed to upload the image. Reason" + e.toString());
    }
  }

  _navigate(String label, String data, IconData icon) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponseViewer(
            label: label,
            data: data,
            icon: icon,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Result",
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: _sendRequest(widget.image),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var visionData =
                    ResponseData.fromJson(jsonDecode(snapshot.data));
                var listLabels = [
                  ['Labels', Icons.label],
                  ['Text', Icons.text_fields],
                  ['Faces', Icons.face],
                  ['Logos', Icons.image]
                ];

                if (visionData != null && visionData.data != null) {
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin:
                              EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
                          child: Card(
                            elevation: 10.0,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Center(
                              child: InkWell(
                                splashColor: Colors.white.withAlpha(100),
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      if (visionData.data.labels != null &&
                                          visionData.data.labels.length > 0) {
                                        _navigate(
                                            listLabels[index][0],
                                            visionData.data.labels.join(", "),
                                            listLabels[index][1]);
                                      } else {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Labels not found!"),
                                          action: SnackBarAction(
                                            label: "Hide",
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        ));
                                      }
                                      break;
                                    case 1:
                                      if (visionData.data.texts != null &&
                                          visionData.data.texts.length > 0) {
                                        _navigate(
                                            listLabels[index][0],
                                            visionData.data.texts.join(" "),
                                            listLabels[index][1]);
                                      } else {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Text not found!"),
                                          action: SnackBarAction(
                                            label: "Hide",
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        ));
                                      }
                                      break;
                                    case 2:
                                      if (visionData.data.faces != null &&
                                          visionData.data.faces.length > 0) {
                                        var faces = new StringBuffer();
                                        for (int i = 0;
                                            i < visionData.data.faces.length;
                                            i++) {
                                          faces.write("\nFace" +
                                              " " +
                                              (i + 1).toString() +
                                              "\n");

                                          visionData.data.faces[i]
                                              .forEach((key, value) {
                                            switch (value) {
                                              case 5:
                                                faces.write(key +
                                                    ": " +
                                                    "VERY_LIKELY\n");
                                                break;
                                              case 4:
                                                faces.write(
                                                    key + ": " + "LIKELY\n");
                                                break;
                                              case 3:
                                                faces.write(
                                                    key + ": " + "POSSIBLE\n");
                                                break;
                                              case 2:
                                                faces.write(
                                                    key + ": " + "UNLIKELY\n");
                                                break;
                                              case 1:
                                                faces.write(key +
                                                    ": " +
                                                    "VERY_UNLIKELY\n");
                                                break;
                                              default:
                                                faces.write(
                                                    key + ": " + "UNKNOWN\n");
                                                break;
                                            }
                                          });
                                        }
                                        _navigate(
                                            listLabels[index][0],
                                            faces.toString(),
                                            listLabels[index][1]);
                                      } else {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Faces not found!"),
                                          action: SnackBarAction(
                                            label: "Hide",
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        ));
                                      }
                                      break;
                                    case 3:
                                      if (visionData.data.logos != null &&
                                          visionData.data.logos.length > 0) {
                                        var predictedLogos = [];
                                        visionData.data.logos
                                            .forEach((element) {
                                          predictedLogos.add(
                                              Map<String, dynamic>.from(
                                                  element)["Description"]);
                                        });

                                        _navigate(
                                            listLabels[index][0],
                                            predictedLogos.join(", "),
                                            listLabels[index][1]);
                                      } else {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Logos not found!"),
                                          action: SnackBarAction(
                                            label: "Hide",
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        ));
                                      }
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                child: ListTile(
                                  leading: Icon(
                                    listLabels[index][1],
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    listLabels[index][0],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: listLabels.length);
                } else {
                  return Center(
                      child: const ListTile(
                    leading: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Oops",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                        "Nothing to show. Please choose a different image"),
                  ));
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: const ListTile(
                    leading: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    title: Text("Oops", style: TextStyle(fontSize: 20)),
                    subtitle:
                        Text("Something went wrong. Please try again later"),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Waiting for Vision result..."),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Loader...',
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
