import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

abstract class RecordingManager {

  static const String _recordFileName = 'record.aac';

  static Future<bool> _isGranted() async {
    final micPermission = await Permission.microphone.request();
    return micPermission.isGranted;
  }

  static Future<bool> startRecording() async {
    if(!(await _isGranted())) {
      return false;
    }
    final path = (await _getRecordingDirectory()).path + '/';
    HapticFeedback.heavyImpact();
    await Record.start(
      path: path + _recordFileName,
      encoder: AudioEncoder.AAC,
      bitRate: 64000,
      samplingRate: 44100,
    );
    return true;
  }

  /// Returning File Path as String
  static Future<String> stopRecording() async {
    await Record.stop();
    HapticFeedback.heavyImpact();
    return (await _getRecordingDirectory()).path + '/' + _recordFileName;
  }

  static Future<Directory> _getRecordingDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final recordingDir = Directory(appDir.path + '/');
    final isDirExist = await recordingDir.exists();
    if(!isDirExist) {
      await recordingDir.create(recursive: true);
    }
    return recordingDir;
  }

}