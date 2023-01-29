import 'package:flutter/material.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'careerpoint.dart';
import 'franchise.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> _stats = [
    "Uttar Pradesh",
    "Bihar",
    "Assam",
    "Arunachal Pradesh"
  ];

  String? _selectedColor;

  final sugars = [
    'Select Gender',
    'Male',
    'Female',
  ];
  String _currentSugars = 'Select Gender';

  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    var _addInvestment;
    var size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
        // child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
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
                    Container(
                      margin: EdgeInsets.only(left: 80),
                      alignment: Alignment.topCenter,
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("First Name",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              height: 80.0,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xff2e4141),
                  hintText: 'Enter First Name',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Last Name",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              height: 80.0,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xff2e4141),
                    hintText: 'Enter Last Name',
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              alignment: Alignment.center,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Email Address",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              height: 80.0,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xff2e4141),
                  hintText: 'Enter Email Address',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Phone Number",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              height: 80.0,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xff2e4141),
                  hintText: 'Enter Phone Number',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Date of Birth",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            Container(
              height: 80.0,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xff2e4141),
                  hintText: 'Enter Date of Birth',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Gender",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              // width: size.width * 0.8,
              child: DropdownButtonFormField<String>(
                dropdownColor: Color(0xff2e4141),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  filled: true,
                  fillColor: Color(0xff2e4141),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff2e4141),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff2e4141),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                ),
                value: _currentSugars,
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Google ad') {
                    return 'Please Google ad';
                  }
                  return null;
                },
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text(
                      '$sugar',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => {
                      FocusScope.of(context).requestFocus(FocusNode()),
                      _currentSugars = val!,
                      if (val.toString() == "Gold")
                        {
                          _addInvestment.scrip = "Gold",
                          _addInvestment.symbol = "GC=F",
                          getPriceAccordingDateCommodity(
                              _addInvestment.symbol, _addInvestment.invesDate)
                        }
                      else
                        {
                          _addInvestment.scrip = "Gold",
                          _addInvestment.symbol = "SI=F",
                          getPriceAccordingDateCommodity(
                              _addInvestment.symbol, _addInvestment.invesDate)
                        }
                    }),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CareerPoint()));
                },
                color: Color(0xff324444),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // ),
    );
  }

  getPriceAccordingDateCommodity(symbol, invesDate) {}
}
