// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/thankyou.dart';

import 'franchise.dart';

class DietsPlanView extends StatefulWidget {
  DietsPlanView(this.Details);
  //const WorkoutPlanView(data, {Key? key}) : super(key: key);
  final Details;
  @override
  State<DietsPlanView> createState() => _DietsPlanViewState();
}

class _DietsPlanViewState extends State<DietsPlanView> {
  var isLoading;

  void initState() {
    super.initState();
    DietsPlanView(widget.Details);
    print("hii_swati");
    print(widget.Details);
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
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                    data: widget.Details,
                    defaultTextStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xff2D2D2D),
                      fontWeight: FontWeight.w300,
                      //  textAlign: TextAlign.justify,
                    )),
              ),
            ),
          ),
        ));
  }
}
