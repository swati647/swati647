// TODO Implement this library.

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rsa_app/front_page.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin_page.dart';
import 'package:http/http.dart' as http;
import 'package:intro_slider/intro_slider.dart';
import 'intro_screen_custom_config.dart';
import 'intro_screen_custom_layout.dart';
import 'intro_screen_default.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  State<IntroScreenDefault> createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Track Your Progress",
        pathImage: "assets/images/intro_screen1.png",
        description:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it.",
        backgroundColor: Color(0xff76909F),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Hassle Free Payment",
        pathImage: "assets/images/intro_screen1.png",
        description:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it.",
        backgroundColor: Color(0xff76909F),
      ),
    );
  }

  Future<void> onDonePress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("is_intro", true);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      renderSkipBtn: const Text("Skip", style: TextStyle(color: Colors.white)),
      renderNextBtn: const Text("Next", style: TextStyle(color: Colors.white)),
      renderDoneBtn: const Text("Done", style: TextStyle(color: Colors.white)),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}
