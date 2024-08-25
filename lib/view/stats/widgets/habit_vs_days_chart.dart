
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view_model/stats_provider.dart';

class HabitVsDaysChart extends StatelessWidget {
  const HabitVsDaysChart({super.key, required this.provider});

  final StatsProvider provider;

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 1.75,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0 , right: 25.0, top: 10.0, bottom: 10.0),
        child: LineChart(lineChartData()),
      ),
    );

  }

  TextStyle titleStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;

    switch (provider.order[value.toInt()-1]) {
      case 1:
        text = 'M';
        break;
      case 2:
        text = 'T';
        break;
      case 3:
        text = 'W';
        break;
      case 4:
        text = 'Th';
        break;
      case 5:
        text = 'F';
        break;
      case 6:
        text = 'S';
        break;
      case 7:
        text = 'Su';
        break;
      default:
        text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: titleStyle()
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Text(
        value.toInt().toString(),
        style: titleStyle(),
        textAlign: TextAlign.right,
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(

      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (lineBarSpot) {
            return Colors.grey.shade600;
          },
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toInt()} habits',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              );

            }).toList();
          }
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return null;
          }).toList();
        },
        handleBuiltInTouches: true,
      ),

      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.deepPurpleAccent.shade200,
              strokeWidth: 0.5,
            );
          },
        horizontalInterval: 1
      ),

      titlesData: FlTitlesData(
        show: true,

        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),

        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: leftTitleWidgets
          ),
        ),
      ),

      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.deepPurpleAccent.shade700,
          width: 0.5,
          strokeAlign: 1
        )
      ),

      minX: 1,
      maxX: 7,
      minY: 0,
      maxY: 10,

      lineBarsData: [
        LineChartBarData(
          spots: provider.chartData,
          isCurved: false,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          color: Colors.deepPurpleAccent
        ),
      ],

    );
  }
}
