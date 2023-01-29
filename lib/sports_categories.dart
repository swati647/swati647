// ignore_for_file: deprecated_member_use

// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';

class SportsCategoryView extends StatefulWidget {
  SportsCategoryView(this.description);
  //const WorkoutPlanView(data, {Key? key}) : super(key: key);
  final description;
  @override
  State<SportsCategoryView> createState() => _SportsCategoryViewState();
}

class _SportsCategoryViewState extends State<SportsCategoryView> {
  void initState() {
    super.initState();
    SportsCategoryView(widget.description);
    print("hii_swati");
    print(widget.description);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sports Category'),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Color(0xff252424), Color(0xff203e3c)],
              //   ),
              color: Color(0xff252424),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff252424), Color(0xff203e3c)],
          )),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              // child: Html(
              //     data: widget.description,
              //     defaultTextStyle: GoogleFonts.poppins(
              //       fontSize: 15,
              //       color: Color(0xfffffffff),
              //       fontWeight: FontWeight.w200,
              //       //  textAlign: TextAlign.justify,
              //     )),
              child: Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Color(0xfffffffff),
                  fontWeight: FontWeight.w200,
                  //  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        )));
  }
}
