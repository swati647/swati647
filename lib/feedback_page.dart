import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedBack extends StatefulWidget {
  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  // List<TextEditingController>? commentController1 = [];
  final commentController1 = TextEditingController();
  final commentController2 = TextEditingController();
  final commentController3 = TextEditingController();
  final commentController4 = TextEditingController();
  final commentController5 = TextEditingController();
  final commentController6 = TextEditingController();
  double emojiRating1 = 0;
  double emojiRating2 = 0;
  double emojiRating3 = 0;
  double emojiRating4 = 0;
  double emojiRating5 = 0;
  double emojiRating6 = 0;

  var feedback_id;

  var star;

  var comment;

  void initState() {
    super.initState();
    _feedback();
  }

  bool isLoading = true;
  List<dynamic> data = [];
  _feedback() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ApiService.Feedbackdata(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      setState(() {
        data = value["data"];
        isLoading = false;
        print("feedbackdataget$data");
        print("feedbackdataLength${data.length}");
        if (data.length > 0) {
          print("feedback_id${data[0]['feedback_id']}");
          print("star${data[0]['star']}");
          print("comment${data[0]['comment']}");
          ;

          setState(() {
            feedback_id = data[0]['feedback_id'];
            star = data[0]['star'];
            comment = data[0]['comment'];
          });
        }
      });
    });
  }

  var feeddata;
  _feedbackpost(int feedback, int stars, String comment) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("comment"));
    setState(() {
      comment = comment;
      // print("commentstatus1$comment");
    });
    ApiService.PostFeedbackdata(pref.getInt("user_id"), feedback, stars,
            comment, pref.getString("token"))
        .then((value) {
      var feeddata = value;
      if (feeddata.length > 0) {
        print("comment${data[0]["comment"]}");
        pref.setString("comment", data[0]["comment"]);
      }
      print("swatiprajapati");
      print(feeddata);
      print("feedbackdata12${feeddata["success"]}");
    });
  }

  @override
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
            "Your Feedback",
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
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
            )),
            child: SingleChildScrollView(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  :
                  // // : data.length > 0
                  // //     ? Container()
                  // : ListView.builder(
                  //     itemCount: 1,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return
                  SizedBox(
                      // height: MediaQuery.of(context).size.height,
                      child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child: Image.asset(
                                          'assets/images/protection.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 75.0, top: 20),
                                            child: Text(
                                              'Hygiene',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 5),
                                              child: Text(
                                                'How clean is the studio?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating1 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating1 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating1 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating1 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating1 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating1 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating1"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        onChanged: ((value) {
                                          comment = value;
                                          print(
                                              'descriptionvalueprint: $comment');
                                        }),
                                        controller: commentController1,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  1,
                                                  emojiRating1.toInt(),
                                                  commentController1.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child: Image.asset(
                                          'assets/images/personal.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 90.0, top: 20),
                                            child: Text(
                                              'Trainers',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 5),
                                              child: Text(
                                                'How good are the trainers?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating2 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating2 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating2 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating2 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating2 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating2 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating2"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 60,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        controller: commentController2,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsets.only(),
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  2,
                                                  emojiRating2.toInt(),
                                                  commentController2.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                    // ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child:
                                          Image.asset('assets/images/gym.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 80.0, top: 20),
                                            child: Text(
                                              'Equipment',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 5),
                                              child: Text(
                                                'How good is the equipment?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating3 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating3 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating3 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating3 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating3 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating3 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating3"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        controller: commentController3,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  3,
                                                  emojiRating3.toInt(),
                                                  commentController3.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child: Image.asset(
                                          'assets/images/money.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 20),
                                            child: Text(
                                              'Value for Money',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 5),
                                              child: Text(
                                                'is it worth the money?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating4 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating4 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating4 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating4 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating4 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating4 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating4"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        controller: commentController4,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  4,
                                                  emojiRating4.toInt(),
                                                  commentController4.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Color(0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child: Image.asset(
                                          'assets/images/safety.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              right: 130.0,
                                              top: 20,
                                            ),
                                            child: Text(
                                              'Safety',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                'COVID-19 safety precautions',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating5 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating5 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating5 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating5 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating5 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating5 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating5"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        controller: commentController5,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  5,
                                                  emojiRating5.toInt(),
                                                  commentController5.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          width: 420,
                          height: 230,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xffFFFFFF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 20),
                                      child: Image.asset(
                                          'assets/images/booking.png'),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 30.0, top: 20),
                                            child: Text(
                                              'Mobile app',
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff000000),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                'Do you like this app?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      unratedColor: Colors.grey,
                                      // itemCount: 5,
                                      // itemSize: 55.0,
                                      updateOnDrag: true,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating6 == 1
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating6 == 2
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating6 == 3
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating6 == 4
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.star,
                                              color: emojiRating6 == 5
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (ratingvalue) {
                                        setState(() {
                                          emojiRating6 = ratingvalue;
                                          print(
                                              {"emojivaluesave$emojiRating6"});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    // child: DottedBorder(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     color: const Color(0xff2D2D2D),
                                    //     strokeWidth: 2,
                                    //     dashPattern: const [
                                    //       7,
                                    //       7,
                                    //     ],
                                    child: Container(
                                      height: 80,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        controller: commentController6,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffFFFFFF),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff2D2D2D)
                                                    .withOpacity(0.20)),
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
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                          hintText: 'Comment',
                                          hintStyle: GoogleFonts.roboto(
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.20),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/feed_send_icon.png'),
                                            ),
                                            color: const Color(0xff2D2D2D)
                                                .withOpacity(0.50),
                                            iconSize: 30,
                                            onPressed: () {
                                              _feedbackpost(
                                                  6,
                                                  emojiRating6.toInt(),
                                                  commentController6.text);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      content: Text(
                                                        "Feedback send successfully",
                                                        style: GoogleFonts.roboto(
                                                            color: const Color(
                                                                0xff2D2D2D),
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
            )));
  }
}
