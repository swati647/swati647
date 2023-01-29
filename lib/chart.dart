import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChartPage(),
    );
  }
}

class ChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Sun', 0),
      _ChartData('Mon', 0),
      _ChartData('Tue', 0),
      _ChartData('Wed', 50),
      _ChartData('Thu', 0),
      _ChartData('Fri', 0),
      _ChartData('Sat', 0)
    ];
    _tooltip = TooltipBehavior(enable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradientColors = LinearGradient(
      colors: [Color(0xff26EE8E), Color(0xffFFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
        body: Container(
      // color: Color(0xffffffffff),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
      )),
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 50,
              interval: 10,
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: GoogleFonts.roboto(
                  color: const Color(0xff21AB60),
                  fontSize: 8,
                  fontWeight: FontWeight.w400),
              majorTickLines: const MajorTickLines(width: 0),
              axisLine: const AxisLine(width: 0)),
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(
                color: Color(0xff26EE8E),
                width: 3,
                dashArray: <double>[40, 14]),
            labelStyle: const TextStyle(
                color: Color(0xff26EE8E),
                fontFamily: 'Poppins',
                fontSize: 13,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          tooltipBehavior: _tooltip,
          series: <ChartSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Gold',
              gradient: gradientColors,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
            )
          ]),
    ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
