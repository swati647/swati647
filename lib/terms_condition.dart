// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  List<dynamic> termsConditions = [token];

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
    ApiService.termsConditions(pref.getString("token")).then((value) {
      data = value["data"];
      setState(() {
        isLoading = false;
        print("termsConditions$data");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(left: 10.0, bottom: 0, top: 60),
                  child: Image.asset('assets/images/terms_conditions.png'),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20, top: 40),
                          child: Text(
                            'Terms & Conditions',
                            style: GoogleFonts.poppins(
                              color: const Color(0xff334141),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.only(right: 50),
                        //     child: Text(
                        //       'Update 09/07/20',
                        //       style: GoogleFonts.poppins(
                        //         color: const Color(0xff334141),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     )),
                      ],
                    ),
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
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
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
    );
  }
}
