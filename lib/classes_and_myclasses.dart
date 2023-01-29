// TODO Implement this library.// ignore_for_file: prefer_const_constructors, unnecessary_new, implementation_imports

// ignore_for_file: prefer_const_constructors, unnecessary_new

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:herraf_app/addcheckout.dart';

// import 'package:herraf_app/api_servivce.dart';
// import 'package:herraf_app/catalog2.dart';
// import 'package:herraf_app/catalog3.dart';

// import 'package:herraf_app/testfile.dart';
// import 'package:herraf_app/textshowmore.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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

class AllClasses extends StatefulWidget {
  const AllClasses({Key? key}) : super(key: key);

  @override
  State<AllClasses> createState() => _AllClassesState();
}

class _AllClassesState extends State<AllClasses> {
  CurrentDate _currentDate = new CurrentDate();
  var class_id;
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateCallback(date);
    classdata(date);
    _myclassdata(date);
  }

  bool isLoading1 = true;
  var res = [];
  Future<void> _myclassdata(date) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ApiService.myclasses(pref.getInt("user_id"), pref.getString("token"), date)
        .then((value) {
      res = value["data"];
      setState(() {
        print("myclassdata$res");
        print("myclasslength1${res.length}");
        isLoading = false;
      });
    });
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
    var imageFile;
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                margin: new EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xff000000)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomePage()));
                      }),
                  Padding(padding: const EdgeInsets.only(left: 8)),
                  Text(
                    "Classes",
                    style: GoogleFonts.poppins(
                        color: Color(0xff212121),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: const EdgeInsets.only(right: 75)),
                ]),
              ),
              Container(
                  margin: new EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  padding: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(kToolbarHeight),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3.0, left: 3.0, right: 3.0, bottom: 3),
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF0DB2C6), width: 10.0),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF0DB2C6),
                                ),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //       color: Color(0xFFFFFFFF), width: 2.0),
                                  //   borderRadius: BorderRadius.circular(0),
                                  //   color: Color(0xFF0DB2C6),
                                  // ),
                                  child: TabBar(
                                    // indicatorSize: TabBarIndicatorSize.label,
                                    // isScrollable: true,
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    // indicatorPadding: EdgeInsets.zero,
                                    // labelPadding:
                                    //     EdgeInsets.only(left: 30, right: 30),
                                    // indicatorWeight: 4,
                                    labelColor: Color(0xFF0DB2C6),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Color(0xFFffffff),
                                    ),
                                    unselectedLabelColor: Color(0xFFFFFFFF),
                                    tabs: [
                                      Tab(
                                        text: "CLASSES",
                                      ),
                                      Tab(
                                        text: "MY CLASSES",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          body: TabBarView(children: [
                            Column(
                              children: [
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : data.length == 0
                                                ? Center(
                                                    child: Text(
                                                      "No data available here",
                                                      style: GoogleFonts.roboto(
                                                          color: Color(
                                                              0xfffffffff),
                                                          fontSize: 20),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        const ScrollPhysics(),
                                                    itemCount: data.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Card(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 15,
                                                            right: 15),
                                                        color: const Color(
                                                            0xffFFFFFF),
                                                        elevation: 5,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child: Text(
                                                                    // "gdfg",
                                                                    "${data[index]["name"]}",
                                                                    style: GoogleFonts.roboto(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
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
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        icon: Image
                                                                            .asset(
                                                                          'assets/images/calendar.png',
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                      ),
                                                                      Text(
                                                                        // '${DateFormat('d MMM, y').format(DateTime.parse(_selectedCurrentDate)).toString()}',
                                                                        '${_selectedCurrentDate}',
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: const Color(0xff2D2D2D)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        icon: Image
                                                                            .asset(
                                                                          'assets/images/chronometer.png',
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                      ),
                                                                      FittedBox(
                                                                        child:
                                                                            Text(
                                                                          // "gdfg",

                                                                          "${data[index]["schedule_time"]}",
                                                                          maxLines:
                                                                              2,
                                                                          style: GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: const Color(0xff2D2D2D)),
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
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          IconButton(
                                                                            icon:
                                                                                Image.asset(
                                                                              'assets/images/personal1.png',
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                            onPressed:
                                                                                () {},
                                                                          ),
                                                                          Text(
                                                                            // "gdfg",
                                                                            "${data[index]["trainer"]}",
                                                                            style: GoogleFonts.roboto(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: const Color(0xff2D2D2D)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        icon: Image
                                                                            .asset(
                                                                          'assets/images/documents.png',
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                      ),
                                                                      Text(
                                                                        // "gdfg",
                                                                        "Slots:${data[index]["spot"]}",
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: const Color(0xff2D2D2D)),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              height: 51,
                                                              color: const Color(
                                                                  0xffFFFFFF),
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right:
                                                                          30),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .bookmark,
                                                                        color: Color(
                                                                            0xff0D83C6),
                                                                      ),
                                                                      Text(
                                                                        'I’M INTERESTED',
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: const Color(0xff0D83C6)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Color(
                                                                            0xff0D83C6),
                                                                      ),
                                                                      Text(
                                                                        'BOOK CLASS',
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: const Color(0xff0D83C6)),
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
                              ],
                            ),
                            Column(
                              children: [
                                G2xSimpleWeekCalendar(
                                  100.0,
                                  DateTime.now(),
                                  dateCallback: (date) => _dateCallback(date),
                                  typeCollapse: true,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : res.length >= 0
                                            ? Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0),
                                                child: Center(
                                                    child: Text(
                                                  "Please contact to admin",
                                                  style: GoogleFonts.roboto(
                                                      color: const Color(
                                                          0xff314545),
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                              )
                                            : ListView.builder(
                                                physics: const ScrollPhysics(),
                                                // itemCount: 2,
                                                itemCount: res.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Card(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    color:
                                                        const Color(0xffFFFFFF),
                                                    elevation: 5,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          color: const Color(
                                                              0xffFFFFFF),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(7.0),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(7.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                // "jhkj",
                                                                '${res[index]["name"]}',
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                        0xff314545)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20,
                                                                  left: 0),
                                                          width: 400,
                                                          height: 160,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xffFFFFFF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    // height: 61,
                                                                    color: Color(
                                                                        0xffFFFFFF),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    // margin: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        IconButton(
                                                                          icon:
                                                                              Image.asset(
                                                                            'assets/images/calendar.png',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${_selectedCurrentDate}',
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: const Color(0xff314545)),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Image.asset(
                                                                            'assets/images/chronometer.png',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          // "jhjk",
                                                                          '${res[index]["schedule_time"]}',
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: const Color(0xff314545)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    color: const Color(
                                                                        0xffFFFFFF),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        IconButton(
                                                                          icon:
                                                                              Image.asset(
                                                                            'assets/images/personal1.png',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          // "jhjk",
                                                                          '${res[index]["trainer"]}',
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: const Color(0xff314545)),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              130,
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Image.asset(
                                                                            'assets/images/documents.png',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          // "hbjhjk",
                                                                          'Slots:${res[index]["spot"]}',
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: const Color(0xff314545)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 51,
                                                          color: const Color(
                                                              0xffFFFFFF),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Icon(
                                                                Icons.bookmark,
                                                                color: Color(
                                                                    0xff0D83C6),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'I’M INTERESTED',
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                        0xff0D83C6)),
                                                              ),
                                                              const SizedBox(
                                                                width: 60,
                                                              ),
                                                              const Icon(
                                                                Icons.add,
                                                                color: Color(
                                                                    0xff0D83C6),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'BOOK CLASS',
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                        0xff0D83C6)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                })),
                              ],
                            )
                          ])))),
            ])));
  }
}
