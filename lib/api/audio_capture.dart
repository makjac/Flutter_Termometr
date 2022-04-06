import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/numdart.dart';

class AudioCapture {
  final FlutterAudioCapture _plugin = FlutterAudioCapture();
  bool isRec = false;

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
    print(arrayComplexAbs(Y));
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
