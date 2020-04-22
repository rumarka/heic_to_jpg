import 'dart:async';
import 'package:flutter/services.dart';

class HeicToJpg {
  static const MethodChannel _channel =
      const MethodChannel('heic_to_jpg');

  static Future<String> convert(String inPath) async {
    final String outPath = await _channel.invokeMethod('convert', inPath);
    return outPath;
  }
}
