// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/intro_screen_default.dart';
import 'dart:collection';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginData {
  var phonenumber;
  var otp;
}

class OtpPage extends StatefulWidget {
  var phonenumber;

  OtpPage(this.phonenumber);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey webViewKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  LoginData _data = LoginData();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    print("phone ${widget.phonenumber}");
    _data.phonenumber = widget.phonenumber;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(5),
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 100),
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.70,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icon/rsa_logo.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: Text(
                                'You will receive OTP via SMS',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xff2D2D2D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35, bottom: 0, right: 35, top: 130),
                              child: SizedBox(
                                child: TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        4) // only allow 5 digit number
                                  ],
                                  // keyboardType: TextInputType.number,
                                  controller: otpController,
                                  onChanged: (value) {
                                    print(_data.phonenumber);
                                    print(_data.otp);
                                    _data.otp = value;
                                    print('otp: $value.length');
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Otp';
                                    } else if (value.length != 4) {
                                      return 'Please enter 4 digit Otp number';
                                    }
                                    return null;
                                  },
                                  style:
                                      const TextStyle(color: Color(0xff2D2D2D)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffFFFFFF),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff314545)
                                                .withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(5.7),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.7),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      hintText: 'Enter Otp',
                                      hintStyle: GoogleFonts.poppins(
                                        color: const Color(0xff2D2D2D)
                                            .withOpacity(0.8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ButtonTheme(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      minWidth: 370.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            print(_data.phonenumber);
                                            if (_formKey.currentState!
                                                .validate()) {
                                              isLoading = true;
                                              ApiService.otp(_data)
                                                  .then((value) async {
                                                isLoading = false;
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var res = value;
                                                print(
                                                    "SwatiAll${res["data"]["id"]}");
                                                if (res["success"]) {
                                                  pref.setInt("user_id",
                                                      res["data"]["id"]);
                                                  pref.setString(
                                                      "token", res["token"]);

                                                  if (pref.getBool(
                                                          "is_intro") ==
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const IntroScreenDefault()));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const HomePage()));
                                                  }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${res["message"]}")));
                                                }
                                              });
                                            }
                                          });
                                        },
                                        color: const Color(0xffFFFFFF),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            side: BorderSide(
                                                color: const Color(0xff133E66)
                                                    .withOpacity(0.8))),
                                        child: isLoading
                                            ? CircularProgressIndicator()
                                            : Text(
                                                "SUBMIT",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                ),
                                              ),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50.0),
                                            child: Text(
                                              'Call me for OTP',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff0DB2C6),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )),
                                  ],
                                )),
                          ])
                        ])))),
          )),
    );
  }
}
