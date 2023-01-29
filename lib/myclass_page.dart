import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rsa_app/Classes_page.dart';
// import 'package:rsa_app/calendar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';
import 'home_page.dart';

class MYClasses extends StatefulWidget {
  const MYClasses({Key? key}) : super(key: key);

  @override
  State<MYClasses> createState() => _MYClassesState();
}

class _MYClassesState extends State<MYClasses> {
  // CurrentDate _currentDate = new CurrentDate();
  var class_id;
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _myclassdata(date);
    _dateCallback(date);
  }

  bool isLoading = true;
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

  String _selectedCurrentDate = DateFormat.yMMMMd().format(DateTime.now());
  int _selectedIndex = 0;
  late DateTime dateCallback;

  var apidate;
  _dateCallback(DateTime date) {
    dateCallback = date;

    setState(() {
      apidate = DateFormat('yyyy-MM-dd').format(dateCallback);
      print("date proper$apidate");
      _selectedCurrentDate = DateFormat.yMMMMd().format(dateCallback);
      print("currentdate $_selectedCurrentDate");
      _myclassdata(apidate);
    });
  }
  //   _dateCallback(DateTime date) {
  //   dateCallback = date;
  //   print(dateCallback);
  // }

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()));
            }),
        title: Text(
          "My Classes",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
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
                      left: 70, right: 0, top: 5, bottom: 5),
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
                                          const MYClasses()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.30,
                              color: const Color(0xffFFFFFF),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'MY CLASSES',
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
                                        const Classes()));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              'CLASSES',
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
          Center(
            child: Column(
              children: <Widget>[
                G2xSimpleWeekCalendar(
                  100.0,
                  DateTime.now(),
                  dateCallback: (date) => _dateCallback(date),
                  typeCollapse: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : res.length >= 0
                      ? Container(
                          padding: const EdgeInsets.only(top: 0),
                          child: Center(
                              child: Text(
                            "Please contact to admin",
                            style: GoogleFonts.roboto(
                                color: const Color(0xff314545), fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                        )
                      : ListView.builder(
                          physics: const ScrollPhysics(),
                          // itemCount: 2,
                          itemCount: res.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              color: const Color(0xffFFFFFF),
                              elevation: 5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: const Color(0xffFFFFFF),
                                    padding: const EdgeInsets.all(7.0),
                                    margin: const EdgeInsets.all(7.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          // "jhkj",
                                          '${res[index]["name"]}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff314545)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.only(top: 20, left: 0),
                                    width: 400,
                                    height: 160,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.only(),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              // height: 61,
                                              color: Color(0xffFFFFFF),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              // margin: const EdgeInsets.all(8.0),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'assets/images/calendar.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${_selectedCurrentDate}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff314545)),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'assets/images/chronometer.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    // "jhjk",
                                                    '${res[index]["schedule_time"]}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff314545)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: const Color(0xffFFFFFF),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'assets/images/personal1.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    // "jhjk",
                                                    '${res[index]["trainer"]}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff314545)),
                                                  ),
                                                  const SizedBox(
                                                    width: 130,
                                                  ),
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'assets/images/documents.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    // "hbjhjk",
                                                    'Slots:${res[index]["spot"]}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff314545)),
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
                                    color: const Color(0xffFFFFFF),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.bookmark,
                                          color: Color(0xff0D83C6),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'I’M INTERESTED',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff0D83C6)),
                                        ),
                                        const SizedBox(
                                          width: 60,
                                        ),
                                        const Icon(
                                          Icons.add,
                                          color: Color(0xff0D83C6),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'BOOK CLASS',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff0D83C6)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))
        ])),
      ),
    );
  }
}
