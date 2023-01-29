// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/src/multipart_file.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rsa_app/Untitled-1.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/bottom_navigatiuon.dart';
import 'package:rsa_app/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/src/form_data.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:async/async.dart';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  EditProfile(this.fullname, this.email, this.mobile, this.dob, this.gender,
      this.profilepic);
  final fullname, email, mobile, dob, gender, profilepic;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> items = ['Male', 'Female'];
  String? selectedItem = 'Male';
  var gender;

  final _formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final profilePicController = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();
  bool showSpinner = false;

  var email;
  var fullname;
  var mobile;
  var dob;

  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path..split('/').last);
        print("imagepiked");
        print(imageFile);
      });
    }
  }

  File? image;

  Future _getFromCamera() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        setState(() {
          imageFile = File(image.path);
          print("imageFileupload");
          print(imageFile);
        });
      } else {
        print('no image selected');
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  var gend;
  @override
  void initState() {
    super.initState();
    gend = widget.gender;
    print("objectwidgetgender");
    print(widget.gender);
    if (gend == 0) {
      selectedItem = 'Female';
      gender = 0;
    } else {
      selectedItem = 'Male';
      gender = 1;
    }
    fullnameController.text = widget.fullname;
    emailController.text = widget.email;
    mobileController.text = widget.mobile;
    dobController.text = widget.dob;
    profilePicController.text = widget.profilepic;
    print("genderprint${widget.gender}");
  }

  // bool isLoading = true;
  var data;
  _editprofile(
    profilePicController,
    fullnameController,
    emailController,
    mobileController,
    dobController,
    genderController,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    print("profilePicController$profilePicController");
    print("fullnameController$fullnameController");
    print("emailController$emailController");
    print("mobileController$mobileController");
    print("dobController$dobController");
    print("genderController$genderController");

    ApiService.EditProfilePost(
      pref.getInt("user_id"),
      profilePicController,
      fullnameController,
      emailController,
      mobileController,
      dobController,
      genderController,
      pref.getString("token"),
    ).then((value) {
      setState(() {
        data = value["data"];
        // isLoading = false;
        if (pref.getInt("user_id")! > 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomNav(0)));
        }

        print(value);
        print("usereditprofiledata${value["success"]}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _addInvestment;

    return Scaffold(
        // backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff314545)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: const Color(0xff314545),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
            )),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                            onTap: _getFromGallery,
                            child: CircleAvatar(
                              radius: 60,
                              child: Center(
                                  child: CircleAvatar(
                                radius: 60,
                                backgroundImage: imageFile == null
                                    ? NetworkImage(
                                        'https://app.ramagyasportsacademy.com/members_image/${widget.profilepic}')
                                    // ? AssetImage('assets/images/banner.png')
                                    : FileImage(imageFile!) as ImageProvider,
                              )),
                            )),
                        InkWell(
                            onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(''),
                                    content: const Text('Please choose option'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _getFromGallery();
                                        },
                                        child: const Text('Gallery'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Camera'),
                                      ),
                                    ],
                                  ),
                                ),
                            child: Positioned(
                              // top: 130.0,
                              // bottom: 1,
                              // right: 1,
                              child: Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(Icons.camera_alt_sharp,
                                      color: Colors.black),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.white,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        50,
                                      ),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(2, 4),
                                        color: Colors.black.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 3,
                                      ),
                                    ]),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Full Name",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff314545),
                            fontWeight: FontWeight.w500))),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xff314545),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff314545)),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      hintText: 'Full Name',
                      hintStyle: GoogleFonts.poppins(
                          color: const Color(0xff314545).withOpacity(.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    controller: fullnameController,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Email Address",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff314545),
                            fontWeight: FontWeight.w500))),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xff314545),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff314545)),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(
                          color: const Color(0xff314545).withOpacity(.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    controller: emailController,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Mobile Number",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff314545),
                            fontWeight: FontWeight.w500))),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xff314545),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff314545)),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      hintText: 'Mobile Number',
                      hintStyle: GoogleFonts.poppins(
                          color: const Color(0xff314545).withOpacity(.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    controller: mobileController,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Date of Birth",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff314545),
                            fontWeight: FontWeight.w500))),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xff314545),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff314545)),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      hintText: 'Date of Birth',
                      hintStyle: GoogleFonts.poppins(
                          color: const Color(0xff314545).withOpacity(.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    controller: dobController,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Gender",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff314545),
                            fontWeight: FontWeight.w500))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: DropdownButtonFormField(
                    // selectedItemBuilder: ,
                    dropdownColor: const Color(0xff2e4141),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      filled: true,
                      fillColor: Color(0xffFFFFFF),
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

                    value: selectedItem,
                    // isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff314545),
                      // size: 15,
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff314545),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),

                    onChanged: (item) => setState(() => {
                          FocusScope.of(context).requestFocus(FocusNode()),
                          selectedItem = item as String?,
                          print("dfgfh$selectedItem$item"),
                          print(selectedItem),
                          selectedItem == "Male" ? gender = 1 : gender = 0
                        }),
                  ),
                ),
                ButtonTheme(
                  minWidth: 300.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      setState(() {
                        print("qerwreqr19");
                        print(imageFile);
                        print(fullnameController.text);
                        print(mobileController.text);
                        print(dobController.text);
                        print(emailController.text);
                        print(gender);
                        ApiService.editProfilePic(
                          imageFile,
                          pref.getInt("user_id"),
                          fullnameController.text,
                          mobileController.text,
                          dobController.text,
                          emailController.text,
                          gender,
                          pref.getString("token"),
                        ).then((value) {
                          var res = value.toString();
                          print("ghffkg$res");

                          if (res == "200") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomNav(0)));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: const Color(0xff99D7FE),
                                content: Text("Edit Profile Successfully",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff314545),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500))));
                          }
                        });
                      });
                    },
                    color: const Color(0xff99D7FE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(
                      "Save Details",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0xff314545),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )));
  }
}
