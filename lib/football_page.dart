import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/api/api_service.dart';
import 'dart:io';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/membership_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class footballPage extends StatefulWidget {
  const footballPage(this.description, this.sport_name, this.image);
  final description;
  final sport_name;
  final image;
  @override
  State<footballPage> createState() => _footballPageState();
}

class _footballPageState extends State<footballPage> {
  static var token;
  void initState() {
    super.initState();
    footballPage(widget.description, widget.sport_name, widget.image);
    print("hii_swati");
    print(widget.description);
    print(widget.sport_name);
    print(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xff324444),
            resizeToAvoidBottomInset: false,
            body: Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff261D1D), Color(0xff203D3C)],
                )),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1.1,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white.withOpacity(1),
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                widget.sport_name == null
                                    ? Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(left: 70),
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          widget.sport_name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              height: 180.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://167.71.232.216/rsa-app-new/public/images/${widget.image}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            widget.description == null
                                ? Center(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            widget.description,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffffffff)),
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.0, right: 170),
                                                child: Text(
                                                  'TIMINGS:',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xffffffff)),
                                                  //  maxLines: 3,
                                                  textAlign: TextAlign.left,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.0, right: 170),
                                                child: Text(
                                                  'EVENING – 5:30PM TO 7:30PM (Tuesday, Thursday and Saturday )',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffffffff)),
                                                  //  maxLines: 2,
                                                  textAlign: TextAlign.left,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))),
        debugShowCheckedModeBanner: false);
  }
}
