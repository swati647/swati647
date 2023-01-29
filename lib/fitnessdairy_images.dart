// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/fitness_imageupload.dart';

import 'dart:io';

import 'package:rsa_app/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'franchise.dart';

class FitnessDairyImages extends StatefulWidget {
  const FitnessDairyImages({Key? key}) : super(key: key);

  @override
  State<FitnessDairyImages> createState() => _FitnessDairyImagesState();
}

class _FitnessDairyImagesState extends State<FitnessDairyImages> {
  // List<dynamic> fitnessimages = [token];
  static var token;

  File? imageFile;
  final picker = ImagePicker();
  File? image;
  Future pickImageC() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);

      if (image == null) return;

      final imageTemp = File(image.path.split('/').last);
      ApiService.fitnessImageDairy(
          pref.getInt("user_id"), pref.getString("token"), image);

      setState(() {
        this.image = imageTemp;
        _FitnessImages();
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
      data = value["data"];
      setState(() {
        isLoading = false;
        print("FitnessImageGet1$data");
        print("FitnessImageGet2${data.length}");
      });
    });
  }

  /// Get from gallery
  Future _getFromGallery() async {
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Fitness Dairy"),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Color(0xffffffff)),
              onPressed: pickImageC,
            ),
          ],
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 1,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xff314545),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 145.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        'https://app.ramagyasportsacademy.com/members_image/${data[index]["image"]}',
                                      )),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: const Text(
                                              '05 Aug, 2022',
                                              style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 25),
                                            child: const Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        width: 75,
                                        height: 30.0,
                                        child: IconButton(
                                          onPressed: () => {},
                                          icon: const Icon(Icons.delete),
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ));
  }
}
