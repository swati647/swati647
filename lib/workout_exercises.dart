// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/workoutexercisescategory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';

class WorkoutExercises extends StatefulWidget {
  const WorkoutExercises({Key? key}) : super(key: key);

  @override
  State<WorkoutExercises> createState() => _WorkoutExercisesState();
}

class _WorkoutExercisesState extends State<WorkoutExercises> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  late DateTime dateCallback;
  _dateCallback(DateTime date) {
    dateCallback = date;
    print(dateCallback);
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
      backgroundColor: const Color(0xffF5F5F5),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF5F5F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "All Exercises",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body:
          // SingleChildScrollView(child:
          Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
        )),
        child: ListView(
          children: [
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WorkoutExercisesCategory()));
              },
              title: Text("Cardio",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Shoulders",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Triceps",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Biceps",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Chest",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Back",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Legs",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
            ListTile(
              title: Text("Abs",
                  style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(0xff2D2D2D).withOpacity(0.70),
                iconSize: 20,
                onPressed: () {},
              ),
            ),
            Divider(
              color: const Color(0xff2D2D2D).withOpacity(0.20),
              thickness: 0,
            ),
          ],
        ),
      ),
    );
  }
}
