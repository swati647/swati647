// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/login_page.dart';
import 'package:rsa_app/otp_screen.dart';
import 'package:rsa_app/api/api_service.dart';
import 'dart:collection';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class LoginData {
  var phonenumber;
  var name;
}

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginData _data = LoginData();
  late ScaffoldMessengerState scaffoldMessenger;

  final GlobalKey webViewKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

//  bool _isLoading = false;
  late String name, phonenumber;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Set Image as Background"),
        //   backgroundColor: Colors.deepOrangeAccent,
        // ),
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/rsa_background.png"),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 150),
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   child: const Padding(
                      //     padding: EdgeInsets.only(left: 20.0, right: 170),
                      //     child: Text(
                      //       'Code',
                      //       style: TextStyle(fontSize: 25, color: Color(0xffC7DFBC)),

                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                          //height: height * 0.4,
                          // color: Colors.amber,
                          child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(left: 23),
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: Text("Phone Number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, bottom: 20, right: 20, top: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                            style: const TextStyle(color: Color(0xffffffff)),
                            // controller: emailaddressController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff314545),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff314545)),
                                  borderRadius: new BorderRadius.circular(5.7),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: new BorderRadius.circular(5.7),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                hintText: 'Enter Phone Number',
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 23),
                                alignment: Alignment.centerLeft,
                                child: const FittedBox(
                                  child: Text("Name",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 20, right: 20, top: 10),
                              child: TextFormField(
                                controller: nameController,
                                onChanged: ((value) {
                                  _data.name = value;
                                  print('namefield: $value');
                                }),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                                style:
                                    const TextStyle(color: Color(0xffffffff)),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xff314545),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xff314545)),
                                      borderRadius: BorderRadius.circular(5.7),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      // borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(5.7),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: 'Enter Name',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ButtonTheme(
                              minWidth: 250.0,
                              height: 55.0,
                              child: RaisedButton(
                                onPressed: () {
                                  print(_data.name);
                                  print(_data.phonenumber);

                                  if (_formKey.currentState!.validate()) {
                                    ApiService.postRegister(_data)
                                        .then((value) {
                                      var res = value;

                                      if (res["success"]) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpPage(
                                                    _data.phonenumber)));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("${res["message"]}")));
                                      }
                                    });
                                  }
                                },
                                color: Color(0xff324444),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]))
                    ])))));
  }
}
