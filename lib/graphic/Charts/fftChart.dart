///=============================================================================
///Name:      main.dart
///Author:    Maksymilian Jackowski
///Created:   02.04.2022
///=============================================================================

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/data_fft.dart';

// ignore: must_be_immutable
class FftChart extends StatelessWidget {
  double? chartHeight;
  double height;
  List<ChartData> data = [];

  FftChart({
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
        title: ChartTitle(text: 'Fast fourier Transform'),
        primaryXAxis: NumericAxis(),
        primaryYAxis: NumericAxis(
          maximum: chartHeight,
          minimum: 0,
        ),
        series: <ChartSeries>[
          FastLineSeries<ChartData, double>(
            animationDelay: 0,
            animationDuration: 0,
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.frequency,
            yValueMapper: (ChartData data, _) => data.power,
          ),
        ],
      ),
    );
  }
}
