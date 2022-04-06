import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/data_handler.dart';

class FftCart extends StatelessWidget {
  double? chartHeight;
  List<ChartData> data = [];

  FftCart({Key? key, this.chartHeight = null, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 630,
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
          )
        ],
      ),
    );
  }
}
