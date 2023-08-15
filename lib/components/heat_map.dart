import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;
  const MyHeatMap({
    super.key,
    required this.datasets,
    required this.startDateYYYYMMDD,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: HeatMap(
        datasets: datasets,
        startDate: DateTime.parse(startDateYYYYMMDD),
        endDate: DateTime.now().add(const Duration(days: 0)),
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Colors.green,
          //2: Colors.red,
          // 3:Colors.blue,
          // 4:Colors.yellow,
          // 5:Colors.purple,
          // 6:Colors.orange,
        },
      ),
    );
  }
}
