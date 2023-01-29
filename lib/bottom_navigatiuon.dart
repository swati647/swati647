// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/attendance_page.dart';
import 'package:rsa_app/diets_plan_view.dart';
import 'package:rsa_app/edit_profile.dart';
import 'package:rsa_app/home_page.dart';
import 'package:rsa_app/membership_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  BottomNav(this.pageIndex);
  int pageIndex;

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
    _userDetails();
    // getData();
  }

  var fullname;
  var email;
  var mobile;
  var dob;
  var gender;
  var profilepic;

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
          // _isCircularLoading = false;
          fullname = dataitem[0]['fullname'];
          email = dataitem[0]['email'];
          mobile = dataitem[0]['mobile'];
          dob = dataitem[0]['dob'];
          gender = dataitem[0]['gender'];
          profilepic = dataitem[0]['profile_pic'];

          // isLoading = false;
          userDetails = false;
        });
      }
    });
  }

  _onItemTapped(int index) {
    _selectedIndex = index;
    print(_selectedIndex);
    setState(() {});
    switch (_selectedIndex) {
      case 0:
        return HomePage();

      case 1:
        return Attendance();

      case 2:
      // return MembershipCard();

      case 3:
        return EditProfile(fullname, email, mobile, dob, gender, profilepic);

      // case 4:
      //   return EditProfile();
    }
  }

  Future<bool> _willPopCallback() async {
    print("ClosingApp");
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => BottomNav(0)));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            body: _onItemTapped(_selectedIndex),
            bottomNavigationBar: new Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: new TextStyle(color: Colors.blue))),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff1D2F2F),
                  selectedLabelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontSize: 12.0),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontSize: 12.0),
                  selectedItemColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  unselectedItemColor: Colors.white.withOpacity(0.6),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/icon/home_icon.png'),
                      ),
                      label: 'Home',
                      backgroundColor: Color(0xff1D2F2F),
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/icon/attendance_icon.png'),
                      ),
                      label: 'Attendance',
                      backgroundColor: Color(0xff1D2F2F),
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/icon/membership_icon.png'),
                      ),
                      label: 'Membership',
                      backgroundColor: Color(0xff1D2F2F),
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/icon/profile_icon.png'),
                      ),
                      label: 'Profile',
                      backgroundColor: Color(0xff1D2F2F),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped),
            )));
  }
}
