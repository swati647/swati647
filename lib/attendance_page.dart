// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'dart:io';
import 'package:rsa_app/tabbar.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/widget/attendance_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late TabController _tabController;
  @override
  List<dynamic> _attendance = [];

  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'LEFT'),
    new Tab(text: 'RIGHT'),
  ];

  @override
  void initState() {
    super.initState();
    _userAttendance();
  }

  var data = [];
  _userAttendance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.attendance(pref.getInt("user_id"), pref.getInt("month"),
            pref.getString("token"))
        .then((value) {
      data = value["data"];
      setState(() {
        print(data.length);
        print("userAttendance${value["data"]["user_id"]}");
      });
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 12,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Attendance"),
            // actions: [
            //   Container(
            //     margin: EdgeInsets.only(right: 10, top: 12),
            //     padding: EdgeInsets.only(
            //       left: 10,
            //     ),
            //     decoration: BoxDecoration(
            //       // color: Color(0xff252424),
            //       border: Border.all(color: Color(0xffffffff)),
            //     ),
            //     // color: Color(0xfffffffff),
            //     child: Row(
            //       children: [
            //         Text(
            //           "2022",
            //           style: GoogleFonts.poppins(
            //             color: Color(0xffffffff),
            //             fontSize: 13,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         IconButton(
            //           onPressed: () {},
            //           icon: const Icon(
            //             Icons.calendar_today,
            //             color: Colors.white,
            //             size: 20.0,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ],
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Color(0xff252424),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff252424), Color(0xff203e3c)],
              )),
              child: Column(
                children: [
                  // SizedBox(
                  //     height: MediaQuery.of(context).size.height * 0.7,
                  //     child: MyHomePage(),),
                  SizedBox(
                    height: 10,
                  ),

                  TabBar(
                    labelColor: Color(0xff314545), //<-- selected text color
                    unselectedLabelColor: Colors.white,
                    // indicatorColor: Color(0xff314545),
                    isScrollable: true,
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(50), // Creates border
                        color: Color(0xffC7DFBC)),
                    tabs: [
                      Tab(
                        child: Text(
                          "January",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "February",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "March",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "April",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "May",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "June",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "July",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "August",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "September",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "October",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "November",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "December",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    // child: Container(

                    child: TabBarView(
                      children: <Widget>[
                        AttendanceData("01"),
                        AttendanceData("02"),
                        AttendanceData("03"),
                        AttendanceData("04"),
                        AttendanceData("05"),
                        AttendanceData("06"),
                        AttendanceData("07"),
                        AttendanceData("08"),
                        AttendanceData("09"),
                        AttendanceData("10"),
                        AttendanceData("11"),
                        AttendanceData("12"),
                      ],
                    ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
