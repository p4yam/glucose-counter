import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_counter/core/utils/app_colors.dart';

class CustomLineChart extends StatelessWidget {
  final List<int> data;

  const CustomLineChart({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flSpotList = <FlSpot>[];
    for (int i = 0; i < data.length; i++)
      flSpotList.add(FlSpot(i.toDouble(), data[i].toDouble()));

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 12, 2, 8),
      child: SizedBox(
        width: Get.width,
        height: 300,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: flSpotList,
                isCurved: true,
                barWidth: 2,
                colors: [
                  AppColor.YellowAccent,
                ],
                belowBarData: BarAreaData(
                  show: true,
                  colors: [AppColor.BlueAccent.withOpacity(0.8)],
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  colors: [AppColor.GreenAccent.withOpacity(0.5)],
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 5,
                  getTitles: (value) {return value.toString();}),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '${value.toInt()}';
                },
              ),
            ),
            axisTitleData: FlAxisTitleData(
                leftTitle:
                    AxisTitle(showTitle: true, titleText: 'Glucose Value', margin: 10),
                bottomTitle: AxisTitle(
                    showTitle: true,
                    margin: 10,
                    titleText: 'Time',
                    // textStyle: yearTextStyle,
                    textAlign: TextAlign.right)),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 2 || value == 3 || value == 4;
              },
            ),
          ),
        ),
      ),
    );
  }
}
