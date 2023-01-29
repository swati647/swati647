// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rsa_app/barcodescanner.dart';
import 'package:rsa_app/feedback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:rsa_app/Classes_page.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/attendance_page.dart';
import 'package:rsa_app/bookslot.dart';
import 'package:rsa_app/edit_profile.dart';
import 'package:rsa_app/fitness_dairy.dart';
import 'package:rsa_app/fitnessdairy_gallery.dart';
import 'package:rsa_app/fitnessdairy_images.dart';
import 'package:rsa_app/football_page.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/image_slider.dart';
import 'package:rsa_app/login_page.dart';
import 'package:rsa_app/membership_card.dart';
import 'package:rsa_app/membership_plan.dart';
import 'package:rsa_app/otp_screen.dart';
import 'package:rsa_app/privacy_policy.dart';
import 'package:rsa_app/profile.dart';
import 'package:rsa_app/qrcode.dart';
import 'package:rsa_app/sports_categories.dart';
import 'package:rsa_app/terms_condition.dart';
import 'package:rsa_app/wallet_payments.dart';
import 'package:rsa_app/wallet_payments.dart';
import 'package:rsa_app/workoutlogger_page.dart';
import 'package:rsa_app/workouttime_page.dart';
import 'package:rsa_app/your_stats.dart';
import 'package:url_launcher/url_launcher.dart';
import 'choose_membership.dart';
import 'classes_and_myclasses.dart';
import 'signin_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyPlatforms {
  String name;
  String icons;
  MyPlatforms({required this.icons, required this.name});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MyPlatforms> ManageStatsNames = [
    MyPlatforms(icons: "assets/icon/yourstats_icon.png", name: "Your Stats"),
    MyPlatforms(icons: "assets/icon/classes_icon.png", name: "Classes"),
    MyPlatforms(icons: "assets/icon/stopwatch_icon.png", name: "Workout Time"),
    MyPlatforms(icons: "assets/icon/notepad_icon.png", name: "Workout Logger"),
    MyPlatforms(icons: "assets/icon/wallet_icon.png", name: "Wallet & Payment"),
    MyPlatforms(icons: "assets/icon/feedback_icon.png", name: "Feedback"),
  ];
  ScrollController _scrollcontroller = ScrollController();

  var now = DateTime.now();

  var _timeString = "${DateTime.now().hour} : ${DateTime.now().minute}";

  String _scanBarcode = '00:00 Hrs';

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  var baseurl;
  var timeupdate;

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    setState(() async {
      _scanBarcode = barcodeScanRes;
      print("_scanBarcode");
      print(_scanBarcode);
      SharedPreferences pref = await SharedPreferences.getInstance();

      ApiService.QrCode(
        _scanBarcode,
        pref.getInt("user_id"),
        _timeString,
        pref.getString("token"),
      ).then((value) {
        print("qrcodedataupload5");
        print(value);
        print(_timeString);
        print(_scanBarcode);
        print("${value["success"]}");

        if (value['success']) {
          print("valuemessageALL");

          timeupdate = _timeString;
          pref.setString("checkIntTime", timeupdate);
          print("timeupdate5");
          print(timeupdate);

          return showDialog(
              context: context,
              builder: (context) {
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                  _attendanceOnDate();
                });
                return AlertDialog(
                  backgroundColor: Color(0xffC7DFBC),
                  content: Text(
                    "${value["message"]}",
                    style: GoogleFonts.roboto(
                        color: Color(0xff314545), fontSize: 13),
                  ),
                );
              });
        }
      });
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  var fullname;
  var email;
  var mobile;
  var dob;
  var gender;
  var profilepic;
  var joined_duration;

  bool _isLoading2 = false;

  final DateFormat formatter = DateFormat('yMMMMd');

  List<dynamic> attendance = [];

  bool isLoading = true;
  List<dynamic> data = [];
  bool isLoading1 = false;

  @override
  static var token;

  var time;

  @override
  void initState() {
    _userInfo();
    _sportsCategory(token);
    _userDetails();
    _BannerData();
    _attendanceOnDate();

    _isLoading2 = false;
    super.initState();
  }

  var qrdata;

  dataLoadFunction() async {
    setState(() {
      _isLoading2 = true;
    });

    setState(() {
      _isLoading2 = false;
    });
  }

  bool isAllExpired = true;
  List<dynamic> memberships = [];
  _userInfo() async {
    setState(() {
      isLoading1 = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.memberships(
      pref.getInt("user_id"),
      pref.getString("token"),
    ).then((value) {
      setState(() {
        var data = value["data"];

        for (var i = 0; i < data.length; i++) {
          if (data[i]["status"] != "Expired") {
            setState(() {
              isAllExpired = false;
            });
          }
        }
        memberships = value["data"];
        print("PRINTmemberships$memberships");
        if (memberships.length > 0) {
          print("user_membership_id${memberships[0]["user_membership_id"]}");
          pref.setInt(
              "user_membership_id", memberships[0]["user_membership_id"]);

          print("Membership_id_print${memberships[0]["membership_id"]}");
          pref.setInt("membership_id", memberships[0]["membership_id"]);
        }

        isLoading1 = false;
      });
    });
  }

  bool _isCircularLoading = true;
  List<dynamic> dataitem = [];
  bool userDetails = true;
  _userDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ApiService.userDetails(
      pref.getInt("user_id"),
      pref.getString("token"),
    ).then((value) {
      dataitem = value["data"];
      if (dataitem.length > 0) {
        print("fullname${dataitem[0]['fullname']}");
        print("mobile${dataitem[0]['mobile']}");
        print("email${dataitem[0]['email']}");
        print("dob${dataitem[0]['dob']}");
        print("gender${dataitem[0]['gender']}");
        print("profile_pic${dataitem[0]['profile_pic']}");
        print("joined_duration${dataitem[0]['joined_duration']}");

        setState(() {
          fullname = dataitem[0]['fullname'];
          email = dataitem[0]['email'];
          mobile = dataitem[0]['mobile'];
          dob = dataitem[0]['dob'];
          gender = dataitem[0]['gender'];
          profilepic = dataitem[0]['profile_pic'];
          joined_duration = dataitem[0]['joined_duration'];
          userDetails = false;
          _isCircularLoading = false;
        });
      }
    });
  }

  List<dynamic> SportsCategory = [token];
  bool _isLoading4 = true;
  List<dynamic> term = [];
  _sportsCategory(token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.SportsCategory(pref.getString("token")).then((value) {
      term = value["data"];
      _isLoading4 = false;
      setState(() {
        print("SportsCategory$term");
        print("SportsCategorylength${term.length}");
      });
    });
  }

  bool _isLoading3 = true;
  List<dynamic> bannerdata = [];
  _BannerData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.BannerImages(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      setState(() {
        bannerdata = value["data"];

        print("BannerImages2$bannerdata");
        print("BannerImagesLength${bannerdata.length}");
        _isLoading3 = false;
      });
    });
  }

  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  _attendanceOnDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.AttendanceOndate(
            pref.getInt("user_id"), cdate, pref.getString("token"))
        .then((value) {
      setState(() {
        attendance = value["data"];
        print("attendanceondate${attendance}");
        print("attendanceondate${attendance.length}");
      });
    });
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isClick = true;

  File? imageFile;
  final picker = ImagePicker();

  /// Get from gallery
  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print("imagepiked");
        print(imageFile);
      });
    }
  }

  _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.clear();
      pref.setBool("is_intro", true);
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  int _currentIndex = 0;

  Future<bool> _onBackPressed() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  _launchURLInsta() async {
    const url = 'https://www.instagram.com/ramagyasportsacademy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLFacebook() async {
    const url = 'https://www.facebook.com/RamagyaSportsAcademy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var format;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: _isCircularLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffffffff),
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 0, right: 20),
                      child: Text(
                        'The Great Sportz',
                        style: GoogleFonts.roboto(
                            color: const Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Column(
                    children: [
                      Builder(builder: (context) {
                        return IconButton(
                            icon: const Icon(Icons.menu,
                                color: Color(0xff263D4C)),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            });
                      }),
                    ],
                  )
                ],
              ),
              key: _scaffoldKey,
              drawer: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff0F1E33),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 10),
                                    child: Text(
                                      'The Great Sportz',
                                      style: GoogleFonts.roboto(
                                          color: const Color(0xff000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  // Stack(
                                  //   children: [
                                  //     DrawerHeader(
                                  //       child:
                                  // Container(
                                  //     padding: const EdgeInsets.only(
                                  //       left: 20,
                                  //       right: 20,
                                  //     ),
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.03,
                                  //     width:
                                  //         MediaQuery.of(context).size.width,
                                  //     child: Image.asset(
                                  //       "assets/icon/rsa_logo.png",
                                  //     )),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/icon/rsa_logo.png",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: Text('Ramagya Sports Academy',
                            style: GoogleFonts.roboto(
                                color: const Color(0xff2D2D2D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        leading: IconButton(
                          icon: Image.asset(
                            'assets/icon/home1_icon.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      ListTile(
                        title: Text('Chat with Us',
                            style: GoogleFonts.roboto(
                                color: const Color(0xff2D2D2D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        leading: IconButton(
                          icon: Image.asset(
                            'assets/icon/chat_icon.png',
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      InkWell(
                          onTap: _launchURLInsta,
                          child: ListTile(
                            title: Text('Follow Us On Instagram',
                                style: GoogleFonts.roboto(
                                    color: const Color(0xff2D2D2D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            leading: IconButton(
                              icon: Image.asset(
                                'assets/icon/followup_icon.png',
                                fit: BoxFit.fill,
                              ),
                              onPressed: _launchURLInsta,
                            ),
                          )),
                      InkWell(
                          onTap: _launchURLFacebook,
                          child: ListTile(
                            title: Text('Like Us On Facebook',
                                style: GoogleFonts.roboto(
                                    color: const Color(0xff2D2D2D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            leading: IconButton(
                              icon: Image.asset(
                                'assets/icon/like_icon.png',
                                fit: BoxFit.fill,
                              ),
                              onPressed: _launchURLFacebook,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 150, left: 20, right: 20),
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (
                                  BuildContext context,
                                ) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xffF5F5F5),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: Text(
                                                'Logout',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff000000),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                          const Divider(
                                            color: Color(0xff2D2D2D),
                                            thickness: 1,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Are you sure you want to logout?',
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                _logout();
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff9DD8FF)
                                                      .withOpacity(0.70),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(25.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Yes',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      color: const Color(
                                                          0xff2D2D2D),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff9DD8FF)
                                                      .withOpacity(0.70),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(25.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cancel',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      color: const Color(
                                                          0xff2D2D2D),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 40),
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff9DD8FF).withOpacity(0.70),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    size: 24.0,
                                    color: Color(0xff2D2D2D),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: const Color(0xff2D2D2D),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
                )),
                child: Column(children: [
                  // const Divider(
                  //   color: Color(0xffFFFFFF),
                  //   thickness: 1,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              greeting(),
                              style: GoogleFonts.roboto(
                                  color: const Color(0xff000000),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 0),
                            child: Row(children: [
                              Text(
                                joined_duration.toString(),

                                // "Joined 2 Days Ago",
                                style: GoogleFonts.roboto(
                                    color: const Color(0xff2D2D2D)
                                        .withOpacity(0.70),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const ImageIcon(
                              AssetImage('assets/icon/notification_icon.png'),
                            ),
                            iconSize: 35,
                            color: const Color(0xffC71A02),
                            onPressed: () {},
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            height: 70,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: CircleAvatar(
                                backgroundColor: const Color(0xffEFEFEF),
                                radius: 39,
                                backgroundImage: imageFile == null
                                    ? NetworkImage(
                                        'https://app.ramagyasportsacademy.com/members_image/$profilepic')
                                    : FileImage(imageFile!) as ImageProvider),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 30, right: 0),
                    child: Row(children: [
                      Text(
                        "Your Memberships",
                        style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading1
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            SizedBox(
                              height: 170,
                              child: ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemExtent: MediaQuery.of(context).size.width,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    if (memberships.isEmpty ||
                                        isAllExpired) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 50,
                                            right: 50,
                                            bottom: 0,
                                            top: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ChooseMemberships()));
                                          },
                                          child: Card(
                                            color: const Color(0xff21AB89),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xff269FA5),
                                                      Color(0xff21AB89),
                                                    ],
                                                  )),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20,
                                                        left: 20,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Text(
                                                            'All memberships expired',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: const Color(
                                                                  0xffFFFFFF),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 20),
                                                            child: Text(
                                                              'Tap to renew now',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: const Color(
                                                                    0xffFFFFFF),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                    for (var i = 0;
                                        i < memberships.length;
                                        i++) ...[
                                      // if (memberships[i]["status"] !=
                                      //     "Expired") ...[
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      MembershipCard(
                                                        memberships[i][
                                                                "user_membership_id"]
                                                            .toString(),
                                                        memberships[i][
                                                                "membership_id"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["duration"]
                                                            .toString(),
                                                        memberships[i][
                                                                "membership_name"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["session"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["startdate"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["endtdate"]
                                                            .toString(),
                                                        memberships[i]["status"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["session_used"]
                                                            .toString(),
                                                        memberships[i]
                                                                ["personal"]
                                                            .toString(),
                                                      )));
                                        },
                                        child: Card(
                                            color: const Color(0xff74c2e7),
                                            margin: const EdgeInsets.only(
                                                left: 50,
                                                right: 50,
                                                bottom: 0,
                                                top: 5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xff34b9ee),
                                                      Color(0xff74c2e7),
                                                    ],
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          icon: Image.asset(
                                                            'assets/icon/rsa_logo_old.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                          iconSize: 60,
                                                          onPressed: () {},
                                                        ),
                                                        Text(
                                                          '${memberships[i]["duration"]} month',
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: const Color(
                                                                0xffffffff),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Text(
                                                        '${memberships[i]["membership_name"]} | ${memberships[i]["session"]} Session',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: const Color(
                                                              0xffffffff),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 35,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'From: ${DateFormat('d MMM, y').format(DateTime.parse(memberships[i]["startdate"])).toString()}',
                                                            // 'From: ${memberships[i]["startdate"]}',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: const Color(
                                                                  0xffffffff),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            'To: ${DateFormat('d MMM, y').format(DateTime.parse(memberships[i]["endtdate"])).toString()}',
                                                            // 'To: ${memberships[i]["endtdate"]}',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: const Color(
                                                                  0xffffffff),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                      // ] else ...[
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 50,
                                      //       right: 50,
                                      //       bottom: 0,
                                      //       top: 5),
                                      //   child: Card(
                                      //     color: Color(0xff74c2e7),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius:
                                      //           BorderRadius.circular(10.0),
                                      //     ),
                                      //     child: Container(
                                      //       decoration: const BoxDecoration(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(20)),
                                      //           gradient: LinearGradient(
                                      //             begin: Alignment.topCenter,
                                      //             end: Alignment.bottomCenter,
                                      //             colors: [
                                      //               Color(0xff34b9ee),
                                      //               Color(0xff74c2e7),
                                      //             ],
                                      //           )),
                                      //       child: Row(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.center,
                                      //         children: [
                                      //           Expanded(
                                      //             child: Container(
                                      //               width:
                                      //                   MediaQuery.of(context)
                                      //                       .size
                                      //                       .width,
                                      //               height:
                                      //                   MediaQuery.of(context)
                                      //                       .size
                                      //                       .height,
                                      //               padding:
                                      //                   const EdgeInsets.only(
                                      //                 top: 20,
                                      //                 left: 20,
                                      //               ),
                                      //               child: Column(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .spaceBetween,
                                      //                 crossAxisAlignment:
                                      //                     CrossAxisAlignment
                                      //                         .stretch,
                                      //                 children: [
                                      //                   GestureDetector(
                                      //                       onTap: () {
                                      //                         Navigator.push(
                                      //                             context,
                                      //                             MaterialPageRoute(
                                      //                                 builder: (BuildContext context) => MembershipCard(
                                      //                                     memberships[i]["user_membership_id"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["duration"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["membership_name"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["session"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["startdate"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["endtdate"]
                                      //                                         .toString(),
                                      //                                     memberships[i]["status"]
                                      //                                         .toString())));
                                      //                       },
                                      //                       child: Text(
                                      //                         'membership expired',
                                      //                         textAlign:
                                      //                             TextAlign
                                      //                                 .left,
                                      //                         style: GoogleFonts
                                      //                             .roboto(
                                      //                           color: const Color(
                                      //                               0xffFFFFFF),
                                      //                           fontSize: 16,
                                      //                           fontWeight:
                                      //                               FontWeight
                                      //                                   .w600,
                                      //                         ),
                                      //                       )),
                                      //                   GestureDetector(
                                      //                       child: Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                                 .only(
                                      //                             bottom: 20),
                                      //                     child: Text(
                                      //                       'Tap to renew now',
                                      //                       textAlign:
                                      //                           TextAlign.left,
                                      //                       style: GoogleFonts
                                      //                           .roboto(
                                      //                         color: const Color(
                                      //                             0xffFFFFFF),
                                      //                         fontSize: 20,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w700,
                                      //                       ),
                                      //                     ),
                                      //                   )),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // ]
                                    ]
                                  ]),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: Image.asset('assets/icon/fstar_icon.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '30',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff000000),
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Rewards Points',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color:
                                    const Color(0xff2D2D2D).withOpacity(0.70),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              child:
                                  Image.asset('assets/icon/ftroffe_icon.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '0',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff000000),
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Your Challenges',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color:
                                    const Color(0xff2D2D2D).withOpacity(0.70),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        scanQR();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff9DD8FF).withOpacity(0.50),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        scanQR();
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: Text(
                                            attendance.length == 0
                                                ? "Check in/out"
                                                : attendance[0]["out_time"] !=
                                                        null
                                                    ? "Check out"
                                                    : "Check in",
                                            style: GoogleFonts.roboto(
                                              color: attendance.length == 0
                                                  ? const Color(0xff0D83C6)
                                                  : attendance[0]["out_time"] !=
                                                          null
                                                      ? Colors.red
                                                      : const Color(0xff0D83C6),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.only(left: 20),
                              //   child: Center(
                              //     child: Text(
                              //       attendance.length == 0
                              //           ? "00:00 Hrs"
                              //           : attendance[0]["out_time"] != null
                              //               ? attendance[0]["out_time"]
                              //               : attendance[0]["in_time"],
                              //       style: GoogleFonts.roboto(
                              //           color: const Color(0xff0D83C6),
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500),
                              //     ),
                              //   ),
                              // ),
                              // ),
                            ],
                          ),
                        ),
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.440,
                          decoration: BoxDecoration(
                              color: const Color(0xff9DD8FF).withOpacity(0.50),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookSlot()));
                            }),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.watch_later),
                                    color: const Color(0xff0D83C6),
                                    iconSize: 20,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const BookSlot()));
                                    },
                                  ),
                                  Text("Book Slot",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0xff0D83C6))),
                                ]),
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffD85A72),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: MediaQuery.of(context).size.height * 0.060,
                            width: MediaQuery.of(context).size.width * 0.440,
                            child: InkWell(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.camera_alt_rounded),
                                  color: const Color(0xffFFFFFF),
                                  iconSize: 20,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FitnessDairy()));
                                  },
                                ),
                                Text("Fitness Diary",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xffFFFFFF))),
                              ],
                            ))),
                      ]),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 30, right: 0),
                    child: Row(children: [
                      Text(
                        "Details",
                        style: GoogleFonts.roboto(
                            color: const Color(0xff2D2D2D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: ManageStatsNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const YourStats()));
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const AllClasses()));
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const WorkoutTime()));
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const WorkoutLogger()));
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const WalletPayments()));
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FeedBack()));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                              spreadRadius: -2.0,
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: -2.0,
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          title: Text(
                                              ManageStatsNames[index].name,
                                              style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff2D2D2D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          leading: Image.asset(
                                            ManageStatsNames[index].icons,
                                            width: 34,
                                            height: 34,
                                            fit: BoxFit.cover,
                                          ),
                                          trailing: IconButton(
                                            icon:
                                                const Icon(Icons.arrow_forward),
                                            color: const Color(0xff3D4F5E),
                                            iconSize: 20,
                                            onPressed: () {
                                              if (index == 0) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const YourStats()));
                                              }
                                              if (index == 1) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const Classes()));
                                              }
                                              if (index == 2) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const WorkoutTime()));
                                              }
                                              if (index == 3) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const WorkoutLogger()));
                                              }
                                              if (index == 4) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const WalletPayments()));
                                              }
                                              if (index == 5) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            FeedBack()));
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          })),
                ]),
              ))),
    );
  }
}
