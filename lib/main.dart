import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/numdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
//===================================================

class _MyAppState extends State<MyApp> {
  FlutterAudioCapture _plugin = new FlutterAudioCapture();
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startCapture() async {
    await _plugin.start(listener, onError, sampleRate: 16000, bufferSize: 3000);
  }

  Future<void> _stopCapture() async {
    await _plugin.stop();
  }

  void listener(dynamic obj) {
    List<double> X = [];
    obj.forEach((element) {
      X.add(element);
    });
    var Y = fft(arrayToComplexArray(Array(X)));
    int i = 0;
    var list = arrayComplexAbs(Y);
    list.forEach((element) => {print('${i++};$element')});
  }

  void onError(Object e) {
    print(e);
  }

  void tooggleRecord() async {
    isRecording ? isRecording = false : isRecording = true;
    if (isRecording) {
      await _startCapture();
    } else {
      await _stopCapture();
    }
    setState(() {});
  }

  Icon _getIcon() =>
      isRecording ? Icon(Icons.stop) : Icon(Icons.keyboard_voice);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Thermometr'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: tooggleRecord,
          child: _getIcon(),
        ),
      ),
    );
  }
}
