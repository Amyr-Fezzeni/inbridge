import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:inbridge/constants/style.dart';
import 'package:inbridge/services/util/ext.dart';
import 'package:inbridge/services/util/language.dart';
import 'package:inbridge/views/widgets/appbar.dart';
import 'package:inbridge/views/widgets/bottuns.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
  ];
  bool global = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Statistics", leading: false),
      backgroundColor: context.bgcolor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(0),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        global = !global;
                      });
                    },
                    child: Txt(global ? "My Stats" : "Global Statistics",
                        color: context.primaryColor))),
            const Gap(0),
            global
                ? const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Center(
                          child: Text("Global statistics"),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: context.w,
                          decoration: BoxDecoration(
                            color: pink.withOpacity(.1),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Txt("Average Star Rating",
                                  color: pink, bold: true),
                              const Gap(10),
                              Txt("4.868", bold: true, size: 18),
                              const Gap(10),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(smallRadius)),
                                  child: Txt("Good", color: Colors.white)),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: LineChart(
                            mainData(),
                          ),
                        )),
                        const Gap(20),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: context.w,
                          decoration: BoxDecoration(
                            color: pink.withOpacity(.1),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                  child: Icon(Icons.arrow_back_ios_rounded,
                                      color: context.iconColor, size: 25)),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Txt("Post frequency metric",
                                        color: pink, bold: true),
                                    const Gap(10),
                                    Txt("5.385", bold: true, size: 18),
                                    const Gap(10),
                                    Txt("+5.93%", color: Colors.green),
                                  ],
                                ),
                              ),
                              InkWell(
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      color: context.iconColor, size: 25)),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            borderButton("Day", radius: smallRadius, border: 1),
                            borderButton("Week",
                                radius: smallRadius, border: 1),
                            borderButton("Month",
                                radius: smallRadius,
                                textColor: pink,
                                border: 2),
                            borderButton("Year",
                                radius: smallRadius, border: 1),
                          ],
                        ),
                      ],
                    ),
                  ),
            const Gap(90)
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      lineTouchData: const LineTouchData(enabled: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 1),
            FlSpot(1, 2),
            FlSpot(2, 4),
            FlSpot(3, 3),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
          ],
          isCurved: false,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 2,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
