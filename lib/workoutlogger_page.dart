// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rsa_app/workout_exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';

class MyDateTime {
  static String formatDate(DateTime date, {String format = "dd/MM/yyyy"}) {
    var str = format.replaceAll(
        "dd", (date.day < 10 ? "0" : "") + date.day.toString());
    str = str.replaceAll(
        "MM", (date.month < 10 ? "0" : "") + date.month.toString());
    str = str.replaceAll("yyyy", date.year.toString());
    return str;
  }

  ///get first date of week
  static DateTime getFirstDateOfWeek(DateTime date) {
    return date.weekday == 7 ? date : date.add(Duration(days: -date.weekday));
  }

  ///get all days of week
  static List<int> getDaysOfWeek(DateTime date) {
    var firstDay = getFirstDateOfWeek(date);
    var days = <int>[];
    for (var i = 0; i < 7; i++) {
      days.add(firstDay.add(Duration(days: i)).day);
    }
    return days;
  }
}

typedef void DateCallback(DateTime val);

class G2xSimpleWeekCalendar extends StatefulWidget {
  G2xSimpleWeekCalendar(
    this.bodyHeight,
    this.currentDate, {
    this.strWeekDays = const [
      "Sun",
      "Mon",
      "Tues",
      "Wed",
      "Thurs",
      "Fri",
      "Sat"
    ],
    this.format = "yyyy/MM/dd",
    required this.dateCallback,
    this.defaultTextStyle =
        const TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
    this.selectedTextStyle =
        const TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
    this.selectedBackgroundDecoration = const BoxDecoration(),
    this.backgroundDecoration = const BoxDecoration(),
    this.typeCollapse = false,
  });
  final DateTime currentDate;
  final List<String> strWeekDays;
  final String format;
  final DateCallback dateCallback;
  //style
  final TextStyle defaultTextStyle;
  final TextStyle selectedTextStyle;
  final BoxDecoration selectedBackgroundDecoration;
  final BoxDecoration backgroundDecoration;
  final bool typeCollapse;
  final double bodyHeight;
  @override
  _G2xSimpleWeekCalendarState createState() => _G2xSimpleWeekCalendarState();
}

class _G2xSimpleWeekCalendarState extends State<G2xSimpleWeekCalendar>
    with TickerProviderStateMixin {
  late DateTime currentDate;
  var weekDays = <int>[];
  var selectedIndex = 0;
  var _close = false;

  //Collapse
  late AnimationController _collapseController;
  late Animation<double> _collpseAnimation;
  var _heightCollapse = 0.0;

  _setSelectedDate(int index) {
    setState(() {
      selectedIndex = index;
      currentDate =
          MyDateTime.getFirstDateOfWeek(currentDate).add(Duration(days: index));
      if (widget.dateCallback != null) widget.dateCallback(currentDate);
    });
  }

  _altertWeek(int days) {
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
      if (widget.dateCallback != null) widget.dateCallback(currentDate);
    });
  }

  _collapse() {
    if (!widget.typeCollapse) return;
    if (_collapseController.status == AnimationStatus.completed && _close) {
      _collapseController.reverse();
      _close = false;
    } else if (_collapseController.status == AnimationStatus.dismissed) {
      _collapseController.forward();
      _close = true;
    }
  }

  @override
  void initState() {
    super.initState();
    currentDate = widget.currentDate;
    // if(widget.dateCallback != null)
    //   widget.dateCallback(currentDate);
    selectedIndex = currentDate.weekday == 7 ? 0 : currentDate.weekday;

    //Collapse
    _heightCollapse = widget.bodyHeight;
    _collapseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _collpseAnimation = Tween<double>(begin: widget.bodyHeight, end: 0)
        .animate(_collapseController);
    _collapseController.addListener(() {
      setState(() {
        _heightCollapse = _collpseAnimation.value;
      });
      if (_collapseController.status == AnimationStatus.completed && !_close) {
        _collapseController.reset();
        _close = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    weekDays = MyDateTime.getDaysOfWeek(currentDate);
    var size = MediaQuery.of(context).size;
    var sizePart = size.width / 4 - 10;
    var rowWeeks = Column(
      children: <Widget>[
        Container(
            decoration: widget.backgroundDecoration,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      width: sizePart * 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            DateFormat.yMMMM().format(DateTime.now()),
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600),
                          )
                          // Text(
                          //     MyDateTime.formatDate(currentDate,
                          //         format: widget.format),
                          //     style: widget.defaultTextStyle),
                        ],
                      )),
                ])),
        Container(
            //height: _heightCollapse,
            decoration: widget.backgroundDecoration,
            padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _altertWeek(-7),
                  child: Icon(Icons.arrow_left,
                      color: widget.defaultTextStyle.color),
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.strWeekDays.map((i) {
                        return InkWell(
                            onTap: () =>
                                _setSelectedDate(widget.strWeekDays.indexOf(i)),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration:
                                  selectedIndex == widget.strWeekDays.indexOf(i)
                                      ? widget.selectedBackgroundDecoration
                                      : BoxDecoration(),
                              child: Column(
                                children: <Widget>[
                                  Text(i,
                                      style: selectedIndex ==
                                              widget.strWeekDays.indexOf(i)
                                          ? widget.selectedTextStyle
                                          : widget.defaultTextStyle),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  selectedIndex == widget.strWeekDays.indexOf(i)
                                      ? CircleAvatar(
                                          backgroundColor:
                                              const Color(0xff1BB6C9),
                                          child: Text(
                                              weekDays[widget.strWeekDays
                                                      .indexOf(i)]
                                                  .toString(),
                                              style: selectedIndex ==
                                                      widget.strWeekDays
                                                          .indexOf(i)
                                                  ? widget.selectedTextStyle
                                                  : widget.defaultTextStyle))
                                      : Text(
                                          weekDays[
                                                  widget.strWeekDays.indexOf(i)]
                                              .toString(),
                                          style: selectedIndex ==
                                                  widget.strWeekDays.indexOf(i)
                                              ? widget.selectedTextStyle
                                              : widget.defaultTextStyle),
                                ],
                              ),
                            ));
                      }).toList()),
                ),
                InkWell(
                  onTap: () => _altertWeek(7),
                  child: Icon(Icons.arrow_right,
                      color: widget.defaultTextStyle.color),
                )
              ],
            ))
      ],
    );
    return rowWeeks;
  }
}

class WorkoutLogger extends StatefulWidget {
  const WorkoutLogger({Key? key}) : super(key: key);

  @override
  State<WorkoutLogger> createState() => _WorkoutLoggerState();
}

class _WorkoutLoggerState extends State<WorkoutLogger> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  late DateTime dateCallback;
  _dateCallback(DateTime date) {
    dateCallback = date;
    print(dateCallback);
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// Future<DateTime> showDatePicker
//     ({
//         @required BuildContext context,
//         @required DateTime initialDate,
//         @required DateTime firstDate,
//         @required DateTime lastDate,
//         SelectableDayPredicate selectableDayPredicate,
//         DatePickerMode initialDatePickerMode: DatePickerMode.day,
//         Locale locale,
//         TextDirection textDirection,
//         TransitionBuilder builder
//     })

//     Future<void> _selectDate(BuildContext context) async {
//     final DateTime d = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015),
//       lastDate: DateTime(2020),
//     );
//     if (d != null)
//       setState(() {e
//         _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
//       });
//   }

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
            "Workout Logs",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_today, color: Color(0xff000000)),
              onPressed: () {
                // _selectDate(context);
                // showDatePicker(
                //     context: context,
                //     initialDate: DateTime.now(),
                //     firstDate: DateTime(2015, 8),
                //     lastDate: DateTime(2101),
                //     );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xff000000)),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
          )),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    G2xSimpleWeekCalendar(
                      100.0,
                      DateTime.now(),
                      dateCallback: (date) => _dateCallback(date),
                      typeCollapse: true,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        // width: 250,
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: Text('+ ADD NEW WORKOUT',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffFFFFFF))),
                          color: const Color(0xff1BB6C9),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const WorkoutExercises()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]))
            ]),
          ),
        ));
  }
}
