import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

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
  final FlutterAudioCapture _plugin = FlutterAudioCapture();
  List<ChartData> data = [];
  bool isRecording = false;
  bool isBlocked = false;
  int samplingRate = 16000;
  int maxFrequency = 0;
  double? chartHeight;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startCapture() async {
    await _plugin.start(listener, onError,
        sampleRate: samplingRate, bufferSize: 5000);
  }

  Future<void> _stopCapture() async {
    await _plugin.stop();
  }

  void listener(dynamic obj) async {
    await _stopCapture();
    draw(obj);
    await _startCapture();
  }

  Future<void> draw(dynamic obj) async {
    data = [];
    List<double> X = [];
    obj.forEach((element) {
      X.add(element);
    });
    var Y = fft(arrayToComplexArray(
        Array(X.getRange(0, (X.length / 2).toInt()).toList())));
    var power = arrayComplexAbs(Y);
    List<double> frequency = [];
    for (int i = 0; i < power.length ~/ 2; i++) {
      frequency.add((i * samplingRate) / (power.length * 4));
      data.add(ChartData(power[i], frequency[i]));
    }
    maxFrequency =
        frequency[arrayArgMax(power.getRangeArray(0, power.length ~/ 2))]
            .round();
    setState(() {});
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

  void blockChart() {
    if (isBlocked) {
      isBlocked = false;
      chartHeight = null;
    } else {
      isBlocked = true;
      chartHeight = 6;
    }
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlockFloatingButton(
              isBlocked: isBlocked,
              selectHandler: blockChart,
            ),
            RecordFloatingButton(
              isRecording: isRecording,
              selectHandler: tooggleRecord,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FftCart(
                data: data,
                chartHeight: chartHeight,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Frequency: $maxFrequency',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
