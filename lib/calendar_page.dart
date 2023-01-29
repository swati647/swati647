import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/myclass_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';
class CurrentDate{
  var calDate;
}
class MyDateTime {
  static String formatDate(DateTime date, {String format = "MMMM d, yy"}) {
    var str = format.replaceAll(
        "d", (date.day < 10 ? "0" : "") + date.day.toString());
    str = str.replaceAll(
        "MMMM", (date.month < 10 ? "0" : "") + date.month.toString());
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
    this.format = "d MMMM, yyyy",
    required this.dateCallback,
    this.defaultTextStyle = const TextStyle(color: Colors.white),
    this.selectedTextStyle = const TextStyle(color: Colors.white),
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
       CurrentDate _currentDate = new CurrentDate();
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
    _currentDate.calDate = widget.currentDate;
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
                              MyDateTime.formatDate(currentDate,
                                  format: widget.format),
                              style: widget.defaultTextStyle),
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
                                  SizedBox(
                                    height: 2,
                                  ),
                                  selectedIndex == widget.strWeekDays.indexOf(i)
                                      ? CircleAvatar(
                                          backgroundColor:Color(0xffC7DFBC),
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