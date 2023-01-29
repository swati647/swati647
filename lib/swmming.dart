// ignore_for_file: deprecated_member_use

import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_line/dotted_line.dart';

class CyclingPage extends StatefulWidget {
  const CyclingPage({Key? key}) : super(key: key);

  @override
  State<CyclingPage> createState() => _CyclingPageState();
}

class _CyclingPageState extends State<CyclingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Cycling",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
            )),
            child: SingleChildScrollView(
              child: SizedBox(
                  // height: MediaQuery.of(context).size.height * 1,
                  child: Column(children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          'Time',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            'Enter hours, minutes and seconds',
                            style: GoogleFonts.roboto(
                              color: const Color(0xff2D2D2D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 40, right: 50, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                "HH",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xff2D2D2D),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                "MM",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xff2D2D2D),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                "SS",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xff2D2D2D),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 0),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 80.0,
                          dashColor: const Color(0xff2D2D2D).withOpacity(0.40),
                          dashRadius: 0.0,
                          dashGapLength: 20.0,
                          // dashGapColor: Colors.transparent,
                          // dashGapGradient: [Colors.red, Colors.blue],
                          dashGapRadius: 0.0,
                        ),
                      )
                    ],
                  ),
                  // ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  height: 180,
                  // width: MediaQuery.of(context).size.width * 1.1,
                  // child: Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   color: const Color(0xffFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          'Distance',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          // maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            'Change units by tapping on it',
                            style: GoogleFonts.roboto(
                              color: const Color(0xff2D2D2D).withOpacity(0.70),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 170),
                            child: Text(
                              "0.0",
                              style: GoogleFonts.roboto(
                                color: const Color(0xff2D2D2D),
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              "km",
                              style: GoogleFonts.roboto(
                                color:
                                    const Color(0xff2D2D2D).withOpacity(0.70),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, top: 0),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 250.0,
                          dashColor: const Color(0xff2D2D2D).withOpacity(0.40),
                          // dashGradient: [Colors.red, Colors.blue],
                          dashRadius: 0.0,
                          dashGapLength: 20.0,
                          // dashGapColor: Colors.transparent,
                          // dashGapGradient: [Colors.red, Colors.blue],
                          dashGapRadius: 0.0,
                        ),
                      )
                    ],
                  ),
                  // ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.060,
                        width: MediaQuery.of(context).size.width * 0.440,
                        decoration: const BoxDecoration(
                            color: Color(0xff21AB60),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          onTap: (() {}),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("SAVE",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0xffFFFFFF))),
                              ]),
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff0D83C6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.440,
                          child: InkWell(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("CLEAR",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: const Color(0xffFFFFFF))),
                            ],
                          ))),
                    ]),
              ])),
            )));
  }
}
