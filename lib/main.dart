// @dart = 2.9
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:rsa_app/bottom_navigatiuon.dart';
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
import 'package:rsa_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const type = 0;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  _checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getInt("user_id") != null) {
      setState(() {
        isAuth = true;
      });
    }
    print("isAuth_${isAuth}");
  }

  @override
  Widget build(BuildContext context) {
    return !isAuth ? const FrontPage() : const HomePage();
  }
}
