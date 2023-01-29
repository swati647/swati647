// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/otp_screen.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/signin_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigatiuon.dart';

class LoginOtpData {
  var phonenumber;
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginOtpData _data = LoginOtpData();
  late ScaffoldMessengerState scaffoldMessenger;

  final GlobalKey webViewKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  int _state = 0;
  late String phonenumber;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
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
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35, bottom: 0, right: 35, top: 200),
                              child: SizedBox(
                                child: TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        10) // only allow 5 digit number
                                  ],
                                  // keyboardType: TextInputType.number,
                                  controller: phonenumberController,
                                  onChanged: ((value) {
                                    _data.phonenumber = value;
                                    print('phonenumberfield: $value.length');
                                  }),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phone number';
                                    } else if (value.length != 10) {
                                      return 'Please enter 10 digit number';
                                    }
                                    return null;
                                  },
                                  style:
                                      const TextStyle(color: Color(0xff2D2D2D)),
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        icon: Image.asset(
                                          'assets/icon/flag_icon.png',
                                          fit: BoxFit.fill,
                                        ),
                                        color: const Color(0xff3D4F5E),
                                        onPressed: () {},
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffFFFFFF),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.40)),
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
                                      isDense: true, // important line
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      hintText: 'Enter Phone Number',
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
                                        // child: _state == 0 ?  setUpButtonChild() :  loginButtonChild()

                                        onPressed: () {
                                          setState(() {
                                            print(_data.phonenumber);

                                            if (_formKey.currentState!
                                                .validate()) {
                                              isLoading = true;
                                              ApiService.postRegister(_data)
                                                  .then((value) async {
                                                isLoading = false;
                                                // SharedPreferences pref =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                var res = value;
                                                print(res);
                                                print(
                                                    "hdkddggfk${res["success"]}");

                                                if (res["success"]) {
                                                  // pref.setString(
                                                  //     "device_token",
                                                  //     res["device_token"]
                                                  //         .toString());
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OtpPage(_data
                                                                  .phonenumber)));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${res["message"]}")));
                                                } else {
                                                  return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 3),
                                                            () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        });
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xffFFFFFF),
                                                          content: Text(
                                                            "${res["message"]}",
                                                            style: GoogleFonts.poppins(
                                                                color: const Color(
                                                                    0xff2D2D2D),
                                                                fontSize: 13),
                                                          ),
                                                        );
                                                      });
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
                                                "SIGN IN",
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
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50.0),
                                            child: Text(
                                              'Use one time sign up ID',
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
                        ]))))));
  }
}
