// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:io';
import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'franchise.dart';

class WorkoutPlanView extends StatefulWidget {
  WorkoutPlanView(this.workout_plan);
  final workout_plan;
  @override
  State<WorkoutPlanView> createState() => _WorkoutPlanViewState();
}

class _WorkoutPlanViewState extends State<WorkoutPlanView> {
  void initState() {
    super.initState();
    WorkoutPlanView(widget.workout_plan);
    print("hiiiiiii");
    print(widget.workout_plan);
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
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
        )),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Html(
                data: widget.workout_plan,
                defaultTextStyle: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w300,
                )),
          ),
        ),
      ),
    );
  }
}
