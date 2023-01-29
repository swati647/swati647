// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/fitnessdairy_images.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class FitnessImageUpload extends StatefulWidget {
  const FitnessImageUpload({Key? key}) : super(key: key);

  @override
  State<FitnessImageUpload> createState() => _FitnessImageUploadState();
}

class _FitnessImageUploadState extends State<FitnessImageUpload> {
  // var image;

  @override
  void initState() {
    super.initState();
  }

  static var token;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 400,
      );

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 300,
        maxHeight: 400,
      );

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Fitness Dairy"),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color(0xff252424),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff252424), Color(0xff203e3c)],
            )),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            InkWell(
                                onTap: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(''),
                                        content:
                                            const Text('Please choose option'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              pickImage();
                                            },
                                            child: const Text('Gallery'),
                                          ),
                                          TextButton(
                                            onPressed: pickImageC,
                                            child: const Text('Camera'),
                                          ),
                                        ],
                                      ),
                                    ),
                                child: CircleAvatar(
                                  radius: 75,
                                  // backgroundColor: Colors.grey.shade200,
                                  child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: image == null
                                          ? AssetImage('assets/images')
                                          : FileImage(image!) as ImageProvider),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            image != null ? Image.file(image!) : Text("")
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200.0,
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
                              hintText: 'Discription',
                              hintStyle: GoogleFonts.poppins(
                                  color: Color(0xffffffff).withOpacity(.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        ButtonTheme(
                          minWidth: 250.0,
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                              //  Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //          builder: (BuildContext context) => CareerPoint()));
                            },
                            color: Color(0xffC7DFBC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              "Save",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff314545),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
