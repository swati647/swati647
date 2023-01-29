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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:rsa_app/Classes_page.dart';
import 'package:rsa_app/Feedback_page.dart';
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
import 'signin_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  ScrollController _scrollcontroller = ScrollController();
  var now = DateTime.now();

  var _timeString = "${DateTime.now().hour} : ${DateTime.now().minute}";

  String _scanBarcode = '00:00 Hrs';

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
                    style: GoogleFonts.poppins(
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

  List<dynamic> _memberships = [];
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
        data = value["data"];
        if (data.length > 0) {
          print("Membershipid${data[0]["user_membership_id"]}");
          pref.setInt("user_membership_id", data[0]["user_membership_id"]);
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

        setState(() {
          fullname = dataitem[0]['fullname'];
          email = dataitem[0]['email'];
          mobile = dataitem[0]['mobile'];
          dob = dataitem[0]['dob'];
          gender = dataitem[0]['gender'];
          profilepic = dataitem[0]['profile_pic'];
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
            actions: <Widget>[
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
              key: _scaffoldKey,
              endDrawer: Drawer(
                  child: Container(
                color: const Color(0xffFFFFFF),
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    InkWell(
                                        // onTap: _getFromGallery,
                                        child: Center(
                                      child: CircleAvatar(
                                          radius: 45,
                                          backgroundImage: imageFile == null
                                              ? NetworkImage(
                                                  'https://app.ramagyasportsacademy.com/members_image/$profilepic')
                                              : FileImage(imageFile!)
                                                  as ImageProvider),
                                    )),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 100,
                                        ),
                                        child: Text(
                                          dataitem.length > 0
                                              ? "$fullname"
                                              : "Rsa",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff334141),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditProfile(fullname, email, mobile,
                                                dob, gender, profilepic)));
                                print("getgender");
                                print(gender);
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Edit Profile",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff314545),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xff314545),
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    YourStats()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/yourstats_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Your Stats",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Classes()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/classes_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Classes",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WorkoutTime()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/stopwatch_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Workout Time",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WorkoutLogger()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/notepad_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Workout Logger",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WalletPayments()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/wallet_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Wallet & Payments",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => FeedBack()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/feedback_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Feedback",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const ImageIcon(
                        AssetImage('assets/icon/slotsbooking_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Book Slot",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FitnessDairyGallery()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/fitnessdairy_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Fitness Dairy",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Attendance()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/myattendance_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("My Attendance",
                          style: GoogleFonts.poppins(
                              color: Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TermsConditions()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/termsconditions_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Terms & Conditions",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const PrivacyPolicy()));
                      },
                      leading: const ImageIcon(
                        AssetImage('assets/icon/privacypolicy_icon.png'),
                        color: Color(0xff314545),
                      ),
                      title: Text("Privacy Policy",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                    const Divider(
                      color: Color(0xff314545),
                      thickness: 1,
                    ),
                    ListTile(
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
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )),
                              height: 300,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Text(
                                          'Logout',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff314545),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    const Divider(
                                      color: Color(0xff314545),
                                      thickness: 1,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Are you sure you want to logout?',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff314545),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ButtonTheme(
                                      minWidth: 350.0,
                                      height: 50.0,
                                      child: RaisedButton(
                                          onPressed: () {
                                            _logout();
                                          },
                                          color: const Color(0xff99D7FE),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xff314545),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ButtonTheme(
                                      minWidth: 350.0,
                                      height: 50.0,
                                      child: RaisedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          color: const Color(0xffD85A72),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xffffffff),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      leading:
                          const Icon(Icons.logout, color: Color(0xff314545)),
                      title: Text("Logout",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff314545),
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              )),
              body: SingleChildScrollView(
                  child: Container(
                // decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [Color(0xff261D1D), Color(0xff203D3C)],
                // )),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          'RSA',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff334141),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(
                          left: 300,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState!.openEndDrawer(),
                        // _scaffoldKey.of(context).openEndDrawer(),
                        // _scaffoldKey.currentState!.openDrawer(),
                        icon: const Icon(Icons.reorder),
                        color: const Color(0xff334141),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: _isLoading3
                        ? const Center(child: CircularProgressIndicator())
                        : CarouselSlider.builder(
                            itemCount: bannerdata.length,
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              height: 140,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              // reverse: false,
                              aspectRatio: 5.0,
                            ),
                            itemBuilder: (context, i, id) {
                              return GestureDetector(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'http://167.71.232.216/rsa-app-new/public/banner/${bannerdata[i]["image"]}',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 30, right: 0),
                    child: Row(children: [
                      Text(
                        "Your Memberships",
                        style: GoogleFonts.poppins(
                            color: const Color(0xff334141),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (BuildContext context) =>
                      //               MembershipCard()));
                      // },
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    child: isLoading1
                        ? Center(child: CircularProgressIndicator())
                        : ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemExtent: MediaQuery.of(context).size.width,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                                if (data.length > 0) ...[
                                  for (var i = 0; i < data.length; i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        // elevation: 5,
                                        color: const Color(0xffD25B20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  const Color(0xff37BAEE)
                                                      .withOpacity(0.80),
                                                  const Color(0xff21A09A)
                                                      .withOpacity(0.10),
                                                ],
                                              )),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 12),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 60,
                                                            child: Image.asset(
                                                                'assets/images/membership_logo.png'),
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 180,
                                                                      bottom:
                                                                          20),
                                                              child: Text(
                                                                '${data[i]["duration"]} month',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Color(
                                                                      0xffffffff),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: Text(
                                                            '${data[i]["membership_name"]} | ${data[i]["session"]} Session',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color(
                                                                  0xffffffff),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      const SizedBox(
                                                        height: 35,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 0,
                                                              ),
                                                              child: Text(
                                                                'From: ${data[i]["startdate"]}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 73,
                                                              ),
                                                              child: Text(
                                                                'To: ${data[i]["endtdate"]}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ] else ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xff21A09A)
                                                    .withOpacity(0.80),
                                                Color(0xff21A09A)
                                                    .withOpacity(0.10),
                                              ],
                                            )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                padding: const EdgeInsets.only(
                                                    top: 50,
                                                    left: 40,
                                                    right: 40),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                        // onTap: () {
                                                        //   Navigator.push(
                                                        //       context,
                                                        //       MaterialPageRoute(
                                                        //           builder: (BuildContext
                                                        //                   context) =>
                                                        //               MembershipCard()));
                                                        // },
                                                        child: Text(
                                                      'All memberships expired',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xff314545),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      height: 40,
                                                    ),
                                                    FlatButton(
                                                      height: 50,
                                                      child: Text(
                                                          'Tap to renew now',
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xff314545))),
                                                      color: const Color(
                                                          0xff99D7FE),
                                                      textColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      onPressed: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (BuildContext
                                                        //                 context) =>
                                                        //             MembershipCard()));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ]),
                  )),
                  InkWell(
                      onTap: () {
                        scanQR();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: attendance.length == 0
                                  ? const Color(0xff99D7FE)
                                  : attendance[0]["out_time"] != null
                                      ? Colors.red
                                      : const Color(0xff99D7FE),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      scanQR();
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Center(
                                        child: Text(
                                          attendance.length == 0
                                              ? "Check in"
                                              : attendance[0]["out_time"] !=
                                                      null
                                                  ? "Check out"
                                                  : "Check in",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff314545),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: const Icon(Icons.watch_later),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Center(
                                child: Text(
                                  attendance.length == 0
                                      ? "00:00 Hrs"
                                      : attendance[0]["out_time"] != null
                                          ? attendance[0]["out_time"]
                                          : attendance[0]["in_time"],
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff334141),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            // ),
                          ],
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 0),
                    child: Row(children: [
                      Text(
                        "Sports Categories",
                        style: GoogleFonts.poppins(
                            color: const Color(0xff334141),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: _isLoading4
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverQuiltedGridDelegate(
                                pattern: [
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 2),
                                ],
                                crossAxisCount: 4,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                              ),
                              itemCount: term.length,
                              itemBuilder: (BuildContext context, index) {
                                return StaggeredGridTile.count(
                                  crossAxisCellCount: 4,
                                  mainAxisCellCount: 4,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  footballPage(
                                                    term[index]["description"],
                                                    term[index]["sport_name"],
                                                    term[index]["image"],
                                                  )));
                                    },
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          term[index]["image"] != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        'https://app.ramagyasportsacademy.com/images/${term[index]["image"]}'),
                                                  ),
                                                )
                                              : Image.asset(
                                                  "assets/images/foot.png",
                                                  fit: BoxFit.cover,
                                                ),
                                          Positioned(
                                            top: 30,
                                            left: 30,
                                            child: Text(
                                              "${term[index]["sport_name"]}",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xffffffff),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                ]),
              ))),
    );
  }
}
