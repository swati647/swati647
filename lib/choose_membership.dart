import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'football_page.dart';
import 'franchise.dart';

class ChooseMemberships extends StatefulWidget {
  const ChooseMemberships({Key? key}) : super(key: key);

  @override
  State<ChooseMemberships> createState() => _ChooseMembershipsState();
}

class _ChooseMembershipsState extends State<ChooseMemberships> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Choose Membership",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(top: 300),
                      child: Text(
                        "No membershps available for renewal",
                        style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D), fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

class Provinces {}
