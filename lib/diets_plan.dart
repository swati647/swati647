// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/diets_plan_view.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class DietsPlan extends StatefulWidget {
  const DietsPlan(this.user_membership_id);
  final String user_membership_id;
  @override
  State<DietsPlan> createState() => _DietsPlanState();
}

class _DietsPlanState extends State<DietsPlan> {
  List<dynamic> _plan = [];

  void initState() {
    super.initState();
    _userdiet(widget.user_membership_id);
    print("WorkoutPlanuser_membership_id${widget.user_membership_id}");
    DietsPlan(widget.user_membership_id);
  }

  bool isLoading = true;
  var data = [];
  _userdiet(user_membership_id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getInt("user_membership_id"));
    print(pref.getInt("user_id"));
    ApiService.diets(user_membership_id, pref.getInt("user_id"),
            pref.getInt("user_membership_id"), pref.getString("token"))
        .then((value) {
      data = value["data"];
      setState(() {
        //_memberships = value;
        print("userdiet${data}");
        print("userdietdata${data.length}");
        isLoading = false;
      });
    });
  }

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
          "Diets Plan",
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
          colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
        )),
        child: Column(
          children: [
            SizedBox(
                height: 300,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : data.length == 0
                        ? Container(
                            padding: const EdgeInsets.only(top: 170),
                            child: Center(
                                child: Text(
                              "No data available here",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff2D2D2D), fontSize: 20),
                              textAlign: TextAlign.center,
                            )),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: const EdgeInsets.all(10.0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: const Color(0xffFFFFFF),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name:",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: const Color(0xff2D2D2D)),
                                          ),
                                          Text(
                                            data[index]["diet_name"].toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: const Color(0xff2D2D2D)),
                                          ),
                                          SizedBox(
                                            // margin: const EdgeInsets.only(
                                            //     left: 0, top: 20, bottom: 10),
                                            width: 100,
                                            height: 40,
                                            child: Card(
                                              color: const Color(0xff9DD8FF),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              DietsPlanView(data[
                                                                      index][
                                                                  "Details"])));
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "View",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xff000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(10.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         "Details",
                                    //         textAlign: TextAlign.left,
                                    //         style: GoogleFonts.poppins(
                                    //             fontWeight: FontWeight.w500,
                                    //             fontSize: 15,
                                    //             color: const Color(0xff2D2D2D)),
                                    //       ),

                                    //       Text(
                                    //         data[index]["Details"].toString(),
                                    //         textAlign: TextAlign.left,
                                    //         style: GoogleFonts.poppins(
                                    //             fontWeight: FontWeight.w400,
                                    //             fontSize: 14,
                                    //             color: const Color(0xff2D2D2D)),
                                    //       ),
                                    //       // ElevatedButton(

                                    //       //   style: ElevatedButton.styleFrom(
                                    //       //     primary: const Color(0xff9DD8FF),
                                    //       //   ),
                                    //       //   onPressed: () {
                                    //       //     Navigator.push(
                                    //       //         context,
                                    //       //         MaterialPageRoute(
                                    //       //             builder: (BuildContext
                                    //       //                     context) =>
                                    //       //                 DietsPlanView(
                                    //       //                     data[index]
                                    //       //                         ["Details"])));
                                    //       //   },
                                    //       //   child: Center(
                                    //       //     child: Text(
                                    //       //       "View",
                                    //       //       style: GoogleFonts.poppins(
                                    //       //         color: const Color(0xff000000),
                                    //       //         fontSize: 15,
                                    //       //         fontWeight: FontWeight.w500,
                                    //       //       ),
                                    //       //       textAlign: TextAlign.center,
                                    //       //     ),
                                    //       //   ),
                                    //       // ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
