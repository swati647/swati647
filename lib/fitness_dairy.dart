// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/fitnessdairy_gallery.dart';
import 'package:rsa_app/fitnessdairy_images.dart';
import 'package:rsa_app/home_page.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class FitnessDairy extends StatefulWidget {
  const FitnessDairy({Key? key}) : super(key: key);

  @override
  State<FitnessDairy> createState() => _FitnessDairyState();
}

class _FitnessDairyState extends State<FitnessDairy> {
  File? imageFile;
  final picker = ImagePicker();

  late File image;

  var description;
  Future _pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
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

  Future pickImageC() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxHeight: 500,
          maxWidth: 500);

      if (image == null) return;

      final imageTemp = File(image.path.split('/').last);
      ApiService.fitnessImageDairy(
          pref.getInt("user_id"), pref.getString("token"), image);

      setState(() {
        this.image = imageTemp;
        _FitnessImages();
        Navigator.push(this.context,
            MaterialPageRoute(builder: (context) => FitnessDairyGallery()));
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _upload(file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var body = {
      "user_id": pref.getInt("user_id"),
      "image": await MultipartFile.fromFile(
        file,
      ),
    };

    print(body);

    Dio dio = Dio();
    dio
        .post("https://app.ramagyasportsacademy.com/api/user-fitness",
            data: FormData.fromMap(body))
        .then((response) {
      var res = (response.data);
      print(res);
      print("imagestatus${res["success"]}");

      if (res['success']) {
      } else {}
    }).catchError((error) => print(error));
  }

  @override
  void initState() {
    super.initState();
    _FitnessImages();
  }

  bool isLoading = true;
  var data;
  _FitnessImages() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.FitnessImageGet(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      setState(() {
        data = value["data"];
        if (data.length > 0) {
          print("description${data[0]['description']}");

          setState(() {
            description = data[0]['description'];
            print("descriptiondata");
          });
        }
        isLoading = false;
        print("FitnessImageGet1$data");
        print("FitnessImageGet2${data.length}");
      });
    });
  }

  bool isLoadingdelete = true;
  var delete;
  Future<void> _FitnessImageDelete(id) async {
    print("idprint");
    print(id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.FitnessImageDelete(id, pref.getString("token")).then((value) {
      var delete = value;
      print(delete);

      isLoadingdelete = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed:
                // () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => HomePage()));
                // },
                () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Fitness Dairy",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Color(0xff000000)),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
            )),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Text(
                    'Save your progress \n Upload your progress pics here \n All pics are private and for your eyes only',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Tap on the button to start',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color(0xff2D2D2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton.icon(
                      icon: IconButton(
                        icon: const Icon(Icons.camera_alt_rounded),
                        color: const Color(0xffFFFFFF),
                        iconSize: 30,
                        onPressed: () {},
                      ),

                      onPressed: pickImageC,
                      //  () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (BuildContext context) =>
                      //               FitnessDairyGallery()));
                      // },
                      label: const Text(
                        "ADD NEW WORKOUT",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff9DD8FF),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
