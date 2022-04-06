import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';

class AudioCapture {
  final FlutterAudioCapture _plugin = FlutterAudioCapture();
  bool isRec = false;
  dynamic data;
  int samleRate = 16000;

  AudioCapture();

  dynamic get getData => data;
  int get getSampleRate => samleRate;

  Future<void> _startCapture() async {
    await _plugin.start(listener, onError,
        sampleRate: samleRate, bufferSize: 5000);
  }

  Future<void> _stopCapture() async {
    await _plugin.stop();
  }

  void listener(dynamic obj) async {
    await _stopCapture();
    //List<double> X = [];
    //obj.forEach((element) {
    //  X.add(element);
    //});
    //var Y = fft(arrayToComplexArray(
    //    Array(X.getRange(0, (X.length / 2).toInt()).toList())));
    //data = arrayComplexAbs(arrayComplexDivisionToScalar(Y, Y.length * 2));
    await _startCapture();
  }

  void onError(Object e) {
    print(e);
  }

  void tooggleRecord() async {
    isRec ? isRec = false : isRec = true;
    if (isRec) {
      await _startCapture();
    } else {
      await _stopCapture();
    }
  }
}
