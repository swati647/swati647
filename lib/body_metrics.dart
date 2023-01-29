// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/MyProgress.dart';
import 'package:rsa_app/api/api_service.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class BodyMetrics extends StatefulWidget {
  const BodyMetrics({Key? key}) : super(key: key);

  @override
  State<BodyMetrics> createState() => _BodyMetricsState();
}

class _BodyMetricsState extends State<BodyMetrics> {
  final bmiController = TextEditingController();
  void initState() {
    super.initState();
    _BodyMetricsData();
    _BodyMetricsval();
  }

  bool isLoading = true;
  List<dynamic> data = [];
  _BodyMetricsData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.BodyMetrics(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      setState(() {
        data = value["data"];
        if (data.length > 0) {
          isLoading = false;
          new Future.delayed(
            new Duration(seconds: 4),
          );
          print("BodyMetricsData$data");
          print("_BodyMetricsDataLength34${data.length}");
        }
      });
    });
  }

  List<MyProgressModel> valdata = [];
  _BodyMetricsval() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ApiService.BodyMetricsData(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      // setState(() {
      valdata = value!;
      if (valdata.length > 0) {
        print("BodyMetricsAllData$valdata");
        print("_BodyMetricsAllDataLength12${valdata.length}");
      }
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
            "Body Metrics",
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
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
              )),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : valdata.length == 0
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: valdata.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? 3
                                      : 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: (2 / 1),
                            ),
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              return GestureDetector(
                                child: Card(
                                  elevation: 3,
                                  color: const Color(0xffFFFFFF),
                                  // decoration: const BoxDecoration(
                                  //     color: Color(0xffFFFFFF),
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(8),
                                  //       topRight: Radius.circular(8),
                                  //       bottomLeft: Radius.circular(8),
                                  //       bottomRight: Radius.circular(8),
                                  //     )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${valdata[index].name}",
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xff2D2D2D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${valdata[index].value}${valdata[index].unit}",
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xff000000),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
        ));
  }
}
