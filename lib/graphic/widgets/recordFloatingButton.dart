///=============================================================================
///Name:      main.dart
///Author:    Maksymilian Jackowski
///Created:   02.04.2022
///=============================================================================

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecordFloatingButton extends StatelessWidget {
  bool isRecording;
  VoidCallback? selectHandler;

  RecordFloatingButton({Key? key, this.isRecording = false, this.selectHandler})
      : super(key: key);

  Icon _getIcon() =>
      isRecording ? const Icon(Icons.stop) : const Icon(Icons.keyboard_voice);

  Color _getColor() => isRecording ? Colors.red : Colors.black;

  String _getText() => isRecording ? 'Recording' : 'Not recording';

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: selectHandler,
      child: _getIcon(),
      backgroundColor: _getColor(),
      foregroundColor: Colors.white,
      tooltip: _getText(),
    );
  }
}
