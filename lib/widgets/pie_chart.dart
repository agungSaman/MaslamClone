import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartLabelInfo extends StatelessWidget {
  final Color color;
  final String label;

  const PieChartLabelInfo({required this.color, Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 12,
        height: 12,
        color: color,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(label,
          style: GoogleFonts.sourceSansPro(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))
    ]);
  }
}

class PieChartWithPercentage extends StatelessWidget {
  final List<PieChartSectionData> dataSet;
  final List<String> labelList;

  const PieChartWithPercentage(
      {Key? key, required this.dataSet, required this.labelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: PieChart(
            PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                sections: dataSet),
          ),
        ),
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: dataSet.length,
                separatorBuilder: (context, index) => const SizedBox(
                      width: 18,
                    ),
                itemBuilder: (context, index) => PieChartLabelInfo(
                    color: dataSet[index].color, label: labelList[index])),
          ),
        )
      ],
    );
  }
}
