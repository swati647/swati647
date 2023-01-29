// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/MyProgress.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/body_metrics.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class MyProgress extends StatefulWidget {
  const MyProgress();

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  final bmiController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final bonemassController = TextEditingController();
  final bodyageController = TextEditingController();
  final proteinController = TextEditingController();
  final fatfreeweightController = TextEditingController();
  final skeletalmuscleController = TextEditingController();
  final musclemassController = TextEditingController();
  final subcutaneousfatController = TextEditingController();
  final visceralfatController = TextEditingController();
  final bmrController = TextEditingController();
  final bodywaterController = TextEditingController();
  final bodyfatController = TextEditingController();
  final abcController = TextEditingController();

  var userId,
      bmi,
      weight,
      height,
      boneMass,
      bodyAge,
      protein,
      fatFreeWeight,
      skeletalMuscle,
      muscleMass,
      subcutaneousFat,
      visceralFat,
      bmr,
      bodyWater,
      bodyFat,
      abc;

  void initState() {
    super.initState();
    _BodyMetricsval();
  }

  List<MyProgressModel> valdata = [];
  _BodyMetricsval() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ApiService.BodyMetricsData(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      // setState(() {
      valdata = value!;
      print("MetricsAllDataget");
      print(valdata.length);
      print(valdata[0].name);
      print(valdata[0].value);

      setState(() {
        bmiController.text = valdata[0].value!;
        weightController.text = valdata[1].value!;
        heightController.text = valdata[2].value!;
        bonemassController.text = valdata[3].value!;
        bodyageController.text = valdata[4].value!;
        proteinController.text = valdata[5].value!;
        fatfreeweightController.text = valdata[6].value!;
        skeletalmuscleController.text = valdata[7].value!;
        musclemassController.text = valdata[8].value!;
        subcutaneousfatController.text = valdata[9].value!;
        visceralfatController.text = valdata[10].value!;
        bmrController.text = valdata[11].value!;
        bodywaterController.text = valdata[12].value!;
        bodyfatController.text = valdata[13].value!;
        abcController.text = valdata[14].value!;
      });
    });
  }

  List<dynamic> prodata = [];
  _myprogress(
    userId,
    bmi,
    weight,
    height,
    boneMass,
    bodyAge,
    protein,
    fatFreeWeight,
    skeletalMuscle,
    muscleMass,
    subcutaneousFat,
    visceralFat,
    bmr,
    bodyWater,
    bodyFat,
    abc,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString("BMI_1", bmi);
      pref.setString("weight_2", weight);
      pref.setString("Height_3", height);
      pref.setString("Bone_Mass_4", boneMass);
      pref.setString("Body_Age_5", bodyAge);
      pref.setString("Protein_6", protein);
      pref.setString("Fat_Free_Weight_7", fatFreeWeight);
      pref.setString("Skeletal_Muscle_8", skeletalMuscle);
      pref.setString("Muscle_Mass_9", muscleMass);
      pref.setString("Subcutaneous_Fat_10", subcutaneousFat);
      pref.setString("Visceral_Fat_11", visceralFat);
      pref.setString("BMR_12", bmr);
      pref.setString("Body_Water_13", bodyWater);
      pref.setString("Body_Fat_14", bodyFat);
      pref.setString("ABc_15", abc);
    });
    ApiService.Postmetricmyprogress(
            pref.getInt("user_id"),
            pref.getString("BMI_1"),
            pref.getString("weight_2"),
            pref.getString("Height_3"),
            pref.getString("Bone_Mass_4"),
            pref.getString("Body_Age_5"),
            pref.getString("Protein_6"),
            pref.getString("Fat_Free_Weight_7"),
            pref.getString("Skeletal_Muscle_8"),
            pref.getString("Muscle_Mass_9"),
            pref.getString("Subcutaneous_Fat_10"),
            pref.getString("Visceral_Fat_11"),
            pref.getString("BMR_12"),
            pref.getString("Body_Water_13"),
            pref.getString("Body_Fat_14"),
            pref.getString("ABc_15"),
            pref.getString("token"))
        .then((value) {
      var prodata = value["status"];
      print(prodata);
      // print("prodataupdatecsad${value["success"]}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("valdata[0].name" + valdata[0].name!);

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
            "My Progress",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
            )),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("BMI",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          // height: 90.0,
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xffFFFFFF),
                              hintText: 'BMI',
                              hintStyle: GoogleFonts.roboto(
                                  color: Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bmiController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("weight",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'weight',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: weightController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Height",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Height',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: heightController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Bone Mass",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Bone Mass',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bonemassController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Body Age",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Body Age',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bodyageController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Protein",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Protein',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: proteinController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Fat Free Weight",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Fat Free Weight',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: fatfreeweightController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Fat Free Weight",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Fat Free Weight',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: fatfreeweightController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Skeletal Muscle",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Skeletal Muscle',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: skeletalmuscleController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Muscle Mass",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Muscle Mass',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: musclemassController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Subcutaneous Fat",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Subcutaneous Fat',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: subcutaneousfatController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Visceral Fat",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Visceral Fat',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: visceralfatController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("BMR",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'BMR',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bmrController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Body Water",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Body Water',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bodywaterController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Body Fat",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'Body Fat',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: bodyfatController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("ABc",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w500))),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Color(0xff2D2D2D)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              hintText: 'ABc',
                              hintStyle: GoogleFonts.roboto(
                                  color:
                                      const Color(0xff2D2D2D).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            controller: abcController,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Need more data to draw a chart",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  icon: IconButton(
                    icon: Image.asset(
                      'assets/icon/details_icon.png',
                      fit: BoxFit.fill,
                    ),
                    color: const Color(0xff0D83C6),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        _myprogress(
                          userId,
                          bmiController.text,
                          weightController.text,
                          heightController.text,
                          bonemassController.text,
                          bodyageController.text,
                          proteinController.text,
                          fatfreeweightController.text,
                          skeletalmuscleController.text,
                          musclemassController.text,
                          subcutaneousfatController.text,
                          visceralfatController.text,
                          bmrController.text,
                          bodywaterController.text,
                          bodyfatController.text,
                          abcController.text,
                        );
                        Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: (context) => const MyProgress()));
                      });
                    },
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyProgress()));
                  },
                  label: Text(
                    "Update stats",
                    style: GoogleFonts.roboto(
                      color: const Color(0xff000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff9DD8FF),
                    // fixedSize: const Size(208, 43),
                  ),
                ),
                // ButtonTheme(
                //   minWidth: 350.0,
                //   height: 50.0,
                //   child: RaisedButton(
                //       onPressed: () {
                //         setState(() {
                //           _myprogress(
                //             userId,
                //             bmiController.text,
                //             weightController.text,
                //             heightController.text,
                //             bonemassController.text,
                //             bodyageController.text,
                //             proteinController.text,
                //             fatfreeweightController.text,
                //             skeletalmuscleController.text,
                //             musclemassController.text,
                //             subcutaneousfatController.text,
                //             visceralfatController.text,
                //             bmrController.text,
                //             bodywaterController.text,
                //             bodyfatController.text,
                //             abcController.text,
                //           );
                //           Navigator.push(
                //               this.context,
                //               MaterialPageRoute(
                //                   builder: (context) => const MyProgress()));
                //         });
                //       },
                //       color: const Color(0xff9DD8FF),
                //       // shape: RoundedRectangleBorder(
                //       //     borderRadius: BorderRadius.circular(40)),
                //       child: Text(
                //         'Update stats',
                //         style: GoogleFonts.roboto(
                //           color: const Color(0xff000000),
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       )),
                // ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
