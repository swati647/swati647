// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:rsa_app/workout_plan_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan(this.user_membership_id);
  final String user_membership_id;
  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  List<dynamic> _plan = [];

  void initState() {
    super.initState();
    _userPlan(widget.user_membership_id);
    print("WorkoutPlanuser_membership_id${widget.user_membership_id}");
    WorkoutPlan(widget.user_membership_id);
  }

  bool isLoading = true;
  List<dynamic> data = [];
  _userPlan(user_membership_id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getInt("user_membership_id"));
    ApiService.plan(user_membership_id, pref.getInt("user_id"),
            pref.getInt("user_membership_id"), pref.getString("token"))
        .then((value) {
      data = value["data"];
      setState(() {
        //_memberships = value;
        print("userPlan${data}");
        print("userPlandata${data.length}");
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
        title: Text(
          "Workout Plan",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
        )),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
                height: 200,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : data.length == 0
                        ? Container(
                            padding: const EdgeInsets.only(top: 170),
                            // height: MediaQuery.of(context).size.height * 1,
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
                              return Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: 390,
                                height: 180,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: const Color(0xffFFFFFF),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 20),
                                            child: Text(
                                              "Name:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Color(0xff133E66)),
                                            ),
                                          ),
                                          const SizedBox(width: 45),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 20),
                                            child: Text(
                                              data[index]["name"],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff133E66)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 20),
                                            child: Text(
                                              "Description:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Color(0xff133E66)),
                                            ),
                                          ),
                                          // SizedBox(width: 30),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 20),
                                            child: Text(
                                              data[index]["description"],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff133E66)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "Notes:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff133E66)),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              data[index]["notes"],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff133E66)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                                              WorkoutPlanView(data[
                                                                      index][
                                                                  "workout_plan"])));
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
                                    ],
                                  ),
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
