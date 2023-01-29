// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class MembershipsRenewal extends StatefulWidget {
  @override
  State<MembershipsRenewal> createState() => _MembershipsRenewalState();
}

class _MembershipsRenewalState extends State<MembershipsRenewal> {
  List<dynamic> _plan = [];

  void initState() {
    super.initState();
    _userInfo();
  }

  bool isLoading = true;
  var data = [];
  _userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.memberships(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      data = value["data"];
      print("membershipdata");
      print(data);
      setState(() {
        print("membershipdata");
        print(data.length);
        isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Memberships Renewal"),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color(0xff252424),
            ),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff252424), Color(0xff203e3c)],
            )),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : data.length == 0
                    ? Container(
                        padding: EdgeInsets.only(top: 170),
                        // height: MediaQuery.of(context).size.height * 1,
                        child: Center(
                            child: Text(
                          "Please contact to admin",
                          style: GoogleFonts.poppins(
                              color: Color(0xfffffffff), fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            children: [
                              Column(children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 250, top: 10),
                                  child: Text(
                                    '${data[i]["membership_name"]} ',
                                    // | ${data[i]["session"]} Session
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Color(0xffffffff)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 40, top: 30),
                                          child: Text(
                                            "Quarterly upgrade",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0xffffffff)),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 45, top: 10),
                                          child: Text(
                                            "\u{20B9} ${data[i]["price"]} ${data[i]["duration"]}/month",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0xffffffff)),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            "Renews on ${data[i]["endtdate"]}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0xffffffff)),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   width: 60,
                                    // ),
                                    // Container(
                                    //   padding: EdgeInsets.only(bottom: 20),
                                    //   child: SizedBox(
                                    //     height: 120,
                                    //     width: 120,
                                    //     child: Card(
                                    //       color: Color(0xffC7DFBC),
                                    //       child: Container(
                                    //         margin: EdgeInsets.only(
                                    //             left: 10, right: 10),
                                    //         height: 20,
                                    //         child: Image.asset(
                                    //             'assets/images/basketball_img.png'),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ]),
                              Divider(
                                color: Colors.white.withOpacity(0.2),
                                // thickness: 0,
                              ),
                              // Column(children: [
                              //   SizedBox(
                              //     height: 10,
                              //   ),
                              //   Container(
                              //     padding: EdgeInsets.only(right: 280, top: 10),
                              //     child: Text(
                              //       'Taekwondo',
                              //       style: GoogleFonts.poppins(
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 16,
                              //           color: Color(0xffffffff)),
                              //       textAlign: TextAlign.left,
                              //     ),
                              //   ),
                              //   Row(
                              //     children: [
                              //       Column(
                              //         children: [
                              //           Container(
                              //             padding:
                              //                 EdgeInsets.only(left: 18, right: 50, top: 10),
                              //             child: Text(
                              //               "Quarterly upgrade",
                              //               style: GoogleFonts.poppins(
                              //                   fontWeight: FontWeight.w500,
                              //                   fontSize: 14,
                              //                   color: Color(0xffffffff)),
                              //               textAlign: TextAlign.left,
                              //             ),
                              //           ),
                              //           Container(
                              //             padding: EdgeInsets.only(right: 45, top: 10),
                              //             child: Text(
                              //               "₹1499/3 months",
                              //               style: GoogleFonts.poppins(
                              //                   fontWeight: FontWeight.w500,
                              //                   fontSize: 14,
                              //                   color: Color(0xffffffff)),
                              //               textAlign: TextAlign.left,
                              //             ),
                              //           ),
                              //           Container(
                              //             padding: EdgeInsets.only(left: 10, top: 10),
                              //             child: Text(
                              //               "Expired on July 25, 2022",
                              //               style: GoogleFonts.poppins(
                              //                   fontWeight: FontWeight.w500,
                              //                   fontSize: 14,
                              //                   color: Color(0xffffffff)),
                              //               textAlign: TextAlign.left,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       SizedBox(
                              //         width: 60,
                              //       ),
                              //       Container(
                              //         padding: EdgeInsets.only(bottom: 20),
                              //         child: SizedBox(
                              //           height: 120,
                              //           width: 120,
                              //           child: Card(
                              //             color: Color(0xffC7DFBC),
                              //             child: Container(
                              //               margin: EdgeInsets.only(left: 10, right: 10),
                              //               height: 20,
                              //               child:
                              //                   Image.asset('assets/images/basketball_img.png'),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   Row(
                              //     children: [
                              //       Container(
                              //         margin: const EdgeInsets.only(
                              //           left: 20,
                              //         ),
                              //         width: 110,
                              //         height: 50,
                              //         child: Card(
                              //           color: Color(0xffC7DFBC),
                              //           child: Row(
                              //             children: <Widget>[
                              //               GestureDetector(
                              //                 onTap: () {},
                              //                 child: Container(
                              //                   padding: EdgeInsets.only(left: 20),
                              //                   child: Text(
                              //                     "Renew",
                              //                     style: GoogleFonts.poppins(
                              //                       color: Color(0xff2E4141),
                              //                       fontSize: 14,
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                     textAlign: TextAlign.center,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   Divider(
                              //     color: Color(0xffffffff),
                              //     thickness: 0,
                              //   ),
                              // ]),
                            ],
                          );
                        })));
  }
}
