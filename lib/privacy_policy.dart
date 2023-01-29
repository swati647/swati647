// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  List<dynamic> termsConditions = [token];

  // ignore: prefer_typing_uninitialized_variables
  static var token;

  @override
  void initState() {
    super.initState();
    _termsConditions(token);
  }

  bool isLoading = true;
  var data;
  _termsConditions(token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.privacyPolicy(pref.getString("token")).then((value) {
      data = value["data"];
      setState(() {
        isLoading = false;
        print("termsConditions$data");
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    margin:
                        const EdgeInsets.only(left: 10.0, bottom: 0, top: 60),
                    child: Image.asset('assets/images/privacy_policy.png'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20, top: 40),
                          child: Text(
                            'Privacy Policy',
                            style: GoogleFonts.poppins(
                              color: const Color(0xff334141),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Text(
                            "${data["description"]}",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff334141),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        )),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
