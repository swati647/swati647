// TODO Implement this library.

// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin_page.dart';
import 'package:http/http.dart' as http;
import 'package:intro_slider/intro_slider.dart';
import 'intro_screen_custom_config.dart';
import 'intro_screen_custom_layout.dart';
import 'intro_screen_default.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage> {
  // List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    // listContentConfig.add(
    //   const ContentConfig(
    //     title: "gfdsgsfg",
    //     pathImage: "assets/images/front_logo.png",
    //     description:
    //         "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it.",
    //     backgroundColor: Color(0xff0DB2C6),
    //   ),
    // );
  }

  Future<void> onSignInPress() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // setState(() {
    //   pref.clear();
    // });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // backgroundColor: Color(0xff1BB6C9),
            resizeToAvoidBottomInset: false,
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff1BB6C9), Color(0xff0DB2C6)],
              )),
              child: SingleChildScrollView(
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 50, right: 50, top: 130),
                            height: 300.0,
                            // width: double.infinity,
                            // height: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/front_img.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 15,
                              left: 80,
                              right: 90,
                            ),
                            height: 50.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/front_logo.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(height: 50),
                          ButtonTheme(
                            minWidth: 350.0,
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              color: const Color(0xff0DB2C6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: const BorderSide(
                                      color: Color(0xff88AB4A))),
                              child: Text(
                                'SIGN IN',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xffffffff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
        debugShowCheckedModeBanner: false);
  }
}
