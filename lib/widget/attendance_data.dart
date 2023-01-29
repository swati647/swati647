import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceData extends StatefulWidget {
  var month;

  AttendanceData(this.month);

  @override
  State<AttendanceData> createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  @override
  void initState() {
    super.initState();
    print(widget.month);
    attendance();
  }

  bool isLoading = true;
  var data;
  Future<void> attendance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.attendance(
            pref.getInt("user_id"), pref.getString("token"), widget.month)
        .then((value) {
      data = value["data"];
      setState(() {
        print("attendance length$data");
        print("attendance length${data.length}");
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          // child: Container(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Color(0xff334141),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Date",
          //               style: GoogleFonts.poppins(
          //                   fontSize: 13,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xffffffff)),
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         // margin: const EdgeInsets.symmetric(vertical: 10),
          //         color: Colors.grey.withOpacity(0.4),
          //         width: 1,
          //       ), // THE DIVIDER. CHANGE THIS TO ACCOMMODATE YOUR NEEDS
          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Check In",
          //               style: GoogleFonts.poppins(
          //                   fontSize: 13,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xffffffff)),
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.symmetric(vertical: 10),
          //         color: Colors.grey.withOpacity(0.4),
          //         width: 1,
          //       ),
          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Check Out",
          //               style: GoogleFonts.poppins(
          //                   fontSize: 13,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xffffffff)),
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         // margin: const EdgeInsets.symmetric(vertical: 10),
          //         color: Colors.grey.withOpacity(0.4),
          //         width: 1,
          //       ),
          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Working Hr’s",
          //               style: GoogleFonts.poppins(
          //                   fontSize: 13,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xffffffff)),
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.symmetric(vertical: 10),
          //         color: Colors.grey.withOpacity(0.4),
          //         width: 1,
          //       ),
          //     ],
          //   ),
          // ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 45,
                      color: Color(0xff203e3c),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        child: Text(
                          "Date",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // const VerticalDivider(
                  //   color: Colors.white,
                  //   thickness: 4,
                  // ),
                  Expanded(
                      child: Container(
                    height: 45,
                    color: Color(0xff203e3c),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right: 30),
                      child: Text(
                        "Check In",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  Expanded(
                    child: Container(
                      height: 45,
                      color: Color(0xff203e3c),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 20),
                        child: Text(
                          "Check Out",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Container(
                    height: 45,
                    color: Color(0xff203e3c),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Text(
                        "Working Hr’s",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: isLoading
                      ? Center(child: const CircularProgressIndicator())
                      : data.length == 0
                          ? Center(
                              child: Text(
                                "No data available here",
                                style: GoogleFonts.poppins(
                                    color: Color(0xfffffffff), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                // return Card(
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  // height: 50,
                                  // color: Colors.yellow,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          data[index]["date"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffffffff)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        data[index]["in_time"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffffffff)),
                                        textAlign: TextAlign.center,
                                      )),
                                      Container(
                                          child: Text(
                                        data[index]["out_time"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffffffff)),
                                        textAlign: TextAlign.center,
                                      )),
                                      Container(
                                          child: Text(
                                        data[index]["diffhr"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffffffff)),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                );
                                // );
                              })),
            ],
          ),
        ));
  }
}
