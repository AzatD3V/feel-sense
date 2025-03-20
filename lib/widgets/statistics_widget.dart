import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/constant/constant_list.dart';

class StatisticsWidget extends StatelessWidget {
  final List<double> listEmotions;
  final List<String> responses;
  const StatisticsWidget(
      {super.key, required this.listEmotions, required this.responses});

  @override
  Widget build(BuildContext context) {
    List<String> romanianNumber = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII'];

    return Expanded(
        child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: customBoxDecoration(),
            height: 200,
            child: listEmotions.length >= 2
                ? AspectRatio(
                    aspectRatio: 1.4,
                    child: LineChart(
                      LineChartData(
                        backgroundColor: Colors.black,
                        gridData: FlGridData(
                          show: true,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              interval: 1,
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  romanianNumber[value.toInt()],
                                  style: GoogleFonts.cinzel(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              interval: 1,
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 &&
                                    index < ConstantList.emotions.length) {
                                  return Text(
                                    ConstantList.emotions[index],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  );
                                }
                                return Text("");
                              },
                              reservedSize: 60,
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            aboveBarData: BarAreaData(
                                show: true,
                                color: Colors.black.withValues(alpha: 0.7)),
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(colors: [
                                  Colors.deepOrange.withValues(alpha: 0.9),
                                  Colors.deepPurple.withValues(alpha: 0.9)
                                ])),
                            spots: List.generate(
                              listEmotions.length,
                              (index) => FlSpot(
                                  index.toDouble(),
                                  listEmotions[
                                      index]), // X: işlem, Y: duygu indeksi
                            ),
                            color: Colors.white,
                            barWidth: 2,
                            curveSmoothness: 0.2,
                            dotData: FlDotData(
                              show: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                        "Henuz yeteri kadar veri toplanmadi ${listEmotions.length}"),
                  )));
  }

  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      boxShadow: [
        BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 0.3)
      ],
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Colors.white,
          Colors.grey,
        ],
      ),
    );
  }
}
