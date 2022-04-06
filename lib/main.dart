import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/numdart.dart';

import './graphic/graphic_base.dart';
import './api/api_base.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
//===================================================

class _MyAppState extends State<MyApp> {
  final capture = AudioCapture();
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  void tooggleRecord() {
    isRecording ? isRecording = false : isRecording = true;
    capture.tooggleRecord();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Thermometr'),
        ),
        floatingActionButton: MainFloatingButton(
          isRecording: isRecording,
          selectHandler: tooggleRecord,
        ),
      ),
    );
  }
}
