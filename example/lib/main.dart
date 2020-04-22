import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HEIC to JPG converter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: const Text('Pick a file...'),
                onPressed: _pickFile,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _path != null
                    ? Image.file(
                        File(_path),
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.cover,
                      )
                    : Container(height: 300.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    final path = await FilePicker.getFilePath(
        type: FileType.CUSTOM, fileExtension: "HEIC");
    if (path != null) {
      final jpgPath = await HeicToJpg.convert(path);
      if (jpgPath != null) {
        setState(() {
          _path = jpgPath;
        });
      }
    }
  }
}
