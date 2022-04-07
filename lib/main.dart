import 'dart:async';

import 'package:fft/api/data_signal.dart';
import 'package:fft/graphic/Charts/signalCart.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

import './graphic/graphic_base.dart';
import './api/api_base.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
//===================================================

class _MyAppState extends State<MyApp> {
  final FlutterAudioCapture _plugin = FlutterAudioCapture();
  List<ChartData> data = [];
  List<DataSignal> signalData = [];
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
    signalData = [];
    List<double> X = [];
    obj.forEach((element) {
      X.add(element);
    });
    var Y =
        fft(arrayToComplexArray(Array(X.getRange(0, X.length ~/ 2).toList())));
    var power = arrayComplexAbs(Y);
    if (isBlocked) {
      power = arrayDivisionToScalar(power, arrayMax(power));
    }
    List<double> frequency = [];
    for (int i = 0; i < power.length ~/ 2; i++) {
      frequency.add((i * samplingRate) / (power.length * 4));
      data.add(ChartData(power[i], frequency[i]));
    }
    maxFrequency =
        frequency[arrayArgMax(power.getRangeArray(0, power.length ~/ 2))]
            .round();

    for (int i = power.length ~/ 4; i < power.length ~/ 2.5; i++) {
      if (isBlocked) {
        double temp = arrayMax(Array(X));
        signalData.add(DataSignal((X[i] / temp).abs(), i.toDouble()));
      } else {
        signalData.add(DataSignal(X[i].abs(), i.toDouble()));
      }
    }
    setState(() {});
  }

  void onError(Object e) {
    // ignore: avoid_print
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
      chartHeight = 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Thermometr'),
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
              SignalChart(
                data: signalData,
                chartHeight: chartHeight,
                height: 300,
              ),
              FftChart(
                data: data,
                chartHeight: chartHeight,
                height: 300,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Frequency: $maxFrequency',
                    style: const TextStyle(fontSize: 20),
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
