// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/swmming.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';

class WorkoutExercisesCategory extends StatefulWidget {
  const WorkoutExercisesCategory({Key? key}) : super(key: key);

  @override
  State<WorkoutExercisesCategory> createState() =>
      _WorkoutExercisesCategoryState();
}

class _WorkoutExercisesCategoryState extends State<WorkoutExercisesCategory> {
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

  final List<Map<String, dynamic>> _items = List.generate(
      10,
      (index) => {
            // "id": index,
            "title": "Cardio $index",
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffF5F5F5),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Cardio",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w400,
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
                              const CyclingPage()));
                },
                title: Text("Cycling",
                    style: GoogleFonts.roboto(
                        color: Color(0xff2D2D2D),
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
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => YourStats()));
                // },
                // leading: Icon(Icons.stairs, color: Color(0xff2D2D2D)),
                title: Text("Elliptical Trainer",
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
                title: Text("Rowing Machine",
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
                title: Text("Running ( Outdoor)",
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
                title: Text("Running (Treadmill)",
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
                title: Text("Stationary Bike",
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
                selectedTileColor: Colors.greenAccent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CyclingPage()));
                },
                title: Text("Swimming",
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
                title: Text("Walking",
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
        ));
  }
}
