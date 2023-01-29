// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class WalletPayments extends StatefulWidget {
  const WalletPayments({Key? key}) : super(key: key);

  @override
  State<WalletPayments> createState() => _WalletPaymentsState();
}

class _WalletPaymentsState extends State<WalletPayments> {
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
        title: Text(
          "Wallet & Payments",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
        )),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            height: 60,
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: Image.asset('assets/images/piggy_bank.png'),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    right: 25.0,
                                  ),
                                  child: Text(
                                    'Wallet',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff000000),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Total balance',
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xff000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              child: RichText(
                            text: TextSpan(
                              text: '₹',
                              style: GoogleFonts.roboto(
                                color:
                                    const Color(0xff000000).withOpacity(0.50),
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '0',
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xff000000),
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 0),
                      //       child: Text(
                      //         '₹0',
                      //         overflow: TextOverflow.ellipsis,
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.roboto(
                      //           color: const Color(0xff000000),
                      //           fontSize: 32,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 95,
                        child: Container(
                          width: 180,
                          // margin: const EdgeInsets.all(25),
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title:
                                          const Text('Enter amount to refill'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          child: Column(
                                            children: const <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: '',
                                                  hintText: '',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: RaisedButton(
                                                  color: Color(0xff314545),
                                                  child: Text(
                                                    "Cancel",
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xffffffff)),
                                                  ),
                                                  onPressed: () {
                                                    // your code
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            RaisedButton(
                                                color: Color(0xffC7DFBC),
                                                child: Text(
                                                  "Ok",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color(0xff314545)),
                                                ),
                                                onPressed: () {
                                                  // your code
                                                }),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  color: const Color(0xff3D4F5E),
                                  iconSize: 20,
                                  onPressed: () {},
                                ),
                                Text('Add Money',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff314545))),
                              ],
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text('Your Payment History',
                                style: GoogleFonts.roboto(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff314545))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Row(
                          children: [
                            Text('Last Successful Payments',
                                style: GoogleFonts.roboto(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff314545))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Text("15 Sep, 2022",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                            GestureDetector(
                                child: Text("\u{20B9} 0",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff3D4F5E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Text("14 Sep, 2022",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                            GestureDetector(
                                child: Text("\u{20B9} 1000",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff3D4F5E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Text("14 Sep, 2022",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                            GestureDetector(
                                child: Text("\u{20B9} 1000",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff3D4F5E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Text("13 Sep, 2022",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                            GestureDetector(
                                child: Text("\u{20B9} 1000",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff3D4F5E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Text("10 Sep, 2022",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff2D2D2D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                            GestureDetector(
                                child: Text("\u{20B9} 1000",
                                    style: GoogleFonts.roboto(
                                        color: const Color(0xff3D4F5E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
