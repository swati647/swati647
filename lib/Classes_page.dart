import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/myclass_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'api/api_service.dart';

class CurrentDate {
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
    this.strWeekDays = const ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
    this.format = "d MMMM, yyyy",
    required this.dateCallback,
    this.defaultTextStyle = const TextStyle(color: Color(0xff000000)),
    this.selectedTextStyle = const TextStyle(color: Color(0xff000000)),
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
    print("today datwwe${_currentDate.calDate}");
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
    // classdata(currentDate);
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
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600),
                          )
                          // MyDateTime.formatDate(currentDate,
                          //     format: widget.format),
                          // style: widget.defaultTextStyle),
                        ],
                      )),
                ])),
        Container(
            decoration: widget.backgroundDecoration,
            padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
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
                                      : const BoxDecoration(),
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
                                              const Color(0xff0DB2C6),
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

class Classes extends StatefulWidget {
  const Classes({Key? key}) : super(key: key);

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  CurrentDate _currentDate = new CurrentDate();
  var class_id;
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateCallback(date);
    classdata(date);
  }

  bool isLoading = true;
  List<dynamic> data = [];
  Future<void> classdata(date) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.ClassData(pref.getString("token"), date).then((value) {
      data = value["data"];
      setState(() {
        print("classdata$data");
        print("classlength${data.length}");
        isLoading = false;
      });
    });
  }

  String _selectedCurrentDate = DateFormat.yMMMM().format(DateTime.now());
  int _selectedIndex = 0;
  late DateTime dateCallback;
  var apidate;
  _dateCallback(DateTime date) {
    dateCallback = date;

    setState(() {
      apidate = DateFormat('yyyy-MM-dd').format(dateCallback);
      print("date proper$apidate");
      _selectedCurrentDate = DateFormat.yMMMM().format(dateCallback);
      print("currentdate $_selectedCurrentDate");
      classdata(apidate);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // centerTitle: true,
          title: Text(
            "Classes",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                color: const Color(0xff0DB2C6),
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffFFFFFF)),
                        color: const Color(0xff0DB2C6),
                      ),
                      margin: const EdgeInsets.only(
                          left: 60, right: 0, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const Classes()));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  color: const Color(0xffFFFFFF),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'CLASSES',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff133E66)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MYClasses()));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  'MY CLASSES',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffffffff)),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(children: <Widget>[
                G2xSimpleWeekCalendar(
                  100.0,
                  DateTime.now(),
                  dateCallback: (date) => _dateCallback(date),
                  typeCollapse: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : data.length == 0
                                ? Center(
                                    child: Text(
                                      "No data available here",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xfffffffff),
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : ListView.builder(
                                    physics: const ScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        color: const Color(0xffFFFFFF),
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    // "gdfg",
                                                    "${data[index]["name"]}",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff2D2D2D)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Image.asset(
                                                          'assets/images/calendar.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                        // '${DateFormat('d MMM, y').format(DateTime.parse(_selectedCurrentDate)).toString()}',
                                                        '${_selectedCurrentDate}',
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xff2D2D2D)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Image.asset(
                                                          'assets/images/chronometer.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                          // "gdfg",

                                                          "${data[index]["schedule_time"]}",
                                                          maxLines: 2,
                                                          style: GoogleFonts.roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xff2D2D2D)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            icon: Image.asset(
                                                              'assets/images/personal1.png',
                                                              fit: BoxFit.fill,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          Text(
                                                            // "gdfg",
                                                            "${data[index]["trainer"]}",
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xff2D2D2D)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Image.asset(
                                                          'assets/images/documents.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                        // "gdfg",
                                                        "Slots:${data[index]["spot"]}",
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xff2D2D2D)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 51,
                                              color: const Color(0xffFFFFFF),
                                              margin: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.bookmark,
                                                        color:
                                                            Color(0xff0D83C6),
                                                      ),
                                                      Text(
                                                        'I’M INTERESTED',
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                                0xff0D83C6)),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xff0D83C6),
                                                      ),
                                                      Text(
                                                        'BOOK CLASS',
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                                0xff0D83C6)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }))),
              ])
            ]),
          ),
        ));
  }
}
