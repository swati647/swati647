import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'football_page.dart';
import 'franchise.dart';

class BookSlot extends StatefulWidget {
  const BookSlot({Key? key}) : super(key: key);

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
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
          "Book Slot",
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
                        "No Records found",
                        style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D), fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
              /*  StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),

                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.only(
                                              left: 30.0, top: 20),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 240,
                                                                  bottom: 0),
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.black
                                                                .withOpacity(1),
                                                            size: 25,
                                                          )),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Form(
                                                          child: Column(
                                                            children: const <
                                                                Widget>[
                                                              Center(
                                                                child: Text(
                                                                  'Please carry a govt. ID with you for verification.Smoking and Drinking is strictly prohibited in or around the school premises. Register entry is compulsory for all players; Entry will be allowed inside the school only 15 mins prior to the booking time',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: Color(
                                                                          0xff000000)),
                                                                  maxLines: 15,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Image.asset(
                                                "assets/images/notification.png"),
                                          )
                                          // child:
                                          // Image.asset("assets/images/notification.png"),
                                          ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/tabletennis.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/basketball.png"),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/badminton.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/fitness.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/squash.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/cricket.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/football_5.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc5deba),
                            ),
                            // height: MediaQuery.of(context).size.height* 0.1,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 25),
                                        child: const Text(
                                          "Table Tennis\n 1 Facility/Session\n Available",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Image.asset(
                                            "assets/images/notification.png"),
                                      ),
                                    ],
                                  ),

                                  height: 145.0,
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
                                  decoration: const BoxDecoration(
                                    //  borderRadius: BorderRadius.circular(5),
                                    //  color: Colors.blue,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/football7.png"),
                                        fit: BoxFit.cover),
                                    //         borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  // child:
                                  //     Image.asset("assets/images/tabletennis.png")
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                            '\u{20B9} 299',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            'Onwards',
                                            style: TextStyle(
                                              color: Color(0xff2E4141),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      width: 75,
                                      height: 30.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //          builder: (BuildContext context) => LetTalk()));
                                        },
                                        color: Color(0xff2E4141),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Book",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // child: Container(

                    //   // width: MediaQuery.of(context).size.width,
                    //   height: 170,

                    //   padding: const EdgeInsets.only(
                    //       left: 10, bottom: 10, right: 10, top: 80),
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,

                    //     image: DecorationImage(
                    //         image:
                    //             AssetImage("assets/images/tabletennis.png"),
                    //         fit: BoxFit.cover),

                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(10),
                    //       topRight: Radius.circular(10),
                    //       bottomLeft: Radius.circular(10),
                    //       bottomRight: Radius.circular(10),
                    //     ),

                    //     // color: Colors.teal,
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                  ]),*/
            ],
          ),
        ),
      ),
    );
  }
}

class Provinces {}
