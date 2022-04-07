///=============================================================================
///Name:      main.dart
///Author:    Maksymilian Jackowski
///Created:   02.04.2022
///=============================================================================

import 'package:fft/api/data_signal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/data_signal.dart';

// ignore: must_be_immutable
class SignalChart extends StatelessWidget {
  double? chartHeight;
  double height;
  List<DataSignal> data = [];

  SignalChart({
    Key? key,
    this.chartHeight,
    this.height = 200,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SfCartesianChart(
        title: ChartTitle(text: 'Real time signal'),
        primaryXAxis: NumericAxis(),
        primaryYAxis: NumericAxis(
          maximum: chartHeight,
          minimum: 0,
        ),
        series: <ChartSeries>[
          FastLineSeries<DataSignal, double>(
            animationDelay: 0,
            animationDuration: 0,
            dataSource: data,
            xValueMapper: (DataSignal data, _) => data.time,
            yValueMapper: (DataSignal data, _) => data.amplitude,
          ),
        ],
      ),
    );
  }
}
