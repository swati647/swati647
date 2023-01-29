// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/body_metrics.dart';
import 'package:rsa_app/celendar.dart';
import 'package:rsa_app/chart.dart';
import 'dart:io';
import 'package:rsa_app/thankyou.dart';
import 'package:table_calendar/table_calendar.dart';
import 'franchise.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkoutTime extends StatefulWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  State<WorkoutTime> createState() => _WorkoutTimeState();
}

class _WorkoutTimeState extends State<WorkoutTime> {
  bool _switchValue = true;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void _toggle() {
    setState(() {});
  }

  @override
  void initState() {
    // _controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Attendance",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              // height: MediaQuery.of(context).size.height * 1.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
              )),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text('Your Journey So Far',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                color: const Color(0xff2D2D2D),
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('1 Day',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xff0D83C6),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          Text('Longest workout streak',
                              style: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(0.70),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('1 Minute',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xff21AB60),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          Text('Avg workout session',
                              style: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(0.70),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('Minutes spent on fitness',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xff2D2D2D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ChartPage()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('Show average',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xff2D2D2D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Column(children: [
                              Transform.scale(
                                  scale: 1.3,
                                  child: Switch(
                                    onChanged: toggleSwitch,
                                    value: isSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: const Color(0xff2D2D2D),
                                    inactiveThumbColor: const Color(0xffffffff),
                                    inactiveTrackColor: const Color(0xff2D2D2D),
                                  )),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                      elevation: 3,
                      margin: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Total time spent on fitness',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('1',
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff0D83C6),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text('Day',
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xff2D2D2D)
                                          .withOpacity(0.70),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('1',
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff0D83C6),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text('Hour',
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xff2D2D2D)
                                          .withOpacity(0.70),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('1',
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff0D83C6),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text('Minute',
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xff2D2D2D)
                                          .withOpacity(0.70),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('Workout Days',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                color: const Color(0xff2D2D2D),
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.all(15),
                    elevation: 3,
                    child: SizedBox(
                        height: 500,
                        child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff203e3c),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TableEventsExample())),
                  ),
                ],
              )),
        ));
  }
}
