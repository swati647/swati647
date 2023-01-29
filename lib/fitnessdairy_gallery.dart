// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rsa_app/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'api/api_service.dart';
import 'package:dio/dio.dart';

class FitnessdairyData {
  var Id;
  var description;
  var image;
  late final String id;
}

class FitnessDairyGallery extends StatefulWidget {
  const FitnessDairyGallery({Key? key}) : super(key: key);

  @override
  State<FitnessDairyGallery> createState() => _FitnessDairyGalleryState();
}

class _FitnessDairyGalleryState extends State<FitnessDairyGallery> {
  FitnessdairyData _data = FitnessdairyData();
  List<TextEditingController>? descriptionController = [];
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  static var token;
  File? image;

  var description;

  var Id;

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
        Navigator.push(
            this.context,
            MaterialPageRoute(
                builder: (context) => const FitnessDairyGallery()));
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
      // print("imageDelete${delete["success"]}");
      isLoadingdelete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
            onPressed:
                //  () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) => const HomePage()));
                // },
                () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
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
              onPressed: pickImageC,
            ),
          ],
        ),
        body: Container(
          constraints: BoxConstraints(
            minHeight: 500,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          // height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffF5F5F5), Color(0xffF5F5F5)],
          )),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : data.length == 0
                        ? Center(
                            child: Text(
                              "No data available here",
                              style: GoogleFonts.roboto(
                                  color: const Color(0xff2D2D2D), fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              descriptionController!
                                  .add(TextEditingController());
                              return Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            color: const Color(0xffFFFFFF),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "21 hours ago",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xff2D2D2D),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 2),
                                                          child: Text(
                                                            "10 Aug, 2022",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: const Color(
                                                                  0xff2D2D2D),
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 240),
                                                        onPressed: () {
                                                          showModalBottomSheet<
                                                              void>(
                                                            context: context,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        25.0),
                                                              ),
                                                            ),
                                                            builder: (
                                                              BuildContext
                                                                  context,
                                                            ) {
                                                              return Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color(
                                                                            0xffFFFFFF),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(20.0),
                                                                          topRight:
                                                                              Radius.circular(20.0),
                                                                          bottomLeft:
                                                                              Radius.circular(20),
                                                                          bottomRight:
                                                                              Radius.circular(20),
                                                                        )),
                                                                height: 300,
                                                                child: Center(
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                          padding: const EdgeInsets.only(
                                                                              top:
                                                                                  30),
                                                                          child:
                                                                              Text(
                                                                            'Delete',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: const Color(0xff2D2D2D),
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )),
                                                                      const Divider(
                                                                        color: Color(
                                                                            0xff2D2D2D),
                                                                        thickness:
                                                                            1,
                                                                      ),
                                                                      Container(
                                                                          padding: const EdgeInsets.only(
                                                                              top:
                                                                                  10),
                                                                          child:
                                                                              Text(
                                                                            'Are you sure you want to delete?',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: const Color(0xff2D2D2D),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      ButtonTheme(
                                                                        minWidth:
                                                                            350.0,
                                                                        height:
                                                                            50.0,
                                                                        child: RaisedButton(
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                _FitnessImageDelete(data[index]["id"]);
                                                                                isLoadingdelete ? const Center(child: CircularProgressIndicator()) : Navigator.push(this.context, MaterialPageRoute(builder: (context) => const FitnessDairyGallery()));
                                                                              });
                                                                            },
                                                                            color: const Color(0xffFFFFFF),
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                                            child: Text(
                                                                              'Yes',
                                                                              style: GoogleFonts.roboto(
                                                                                color: const Color(0xff2D2D2D),
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      ButtonTheme(
                                                                        minWidth:
                                                                            350.0,
                                                                        height:
                                                                            50.0,
                                                                        child: RaisedButton(
                                                                            onPressed: () => Navigator.pop(context),
                                                                            color: const Color(0xffFFFFFF),
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                                            child: Text(
                                                                              'Cancel',
                                                                              style: GoogleFonts.roboto(
                                                                                color: const Color(0xff2D2D2D),
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
                                                        icon: const ImageIcon(
                                                          AssetImage(
                                                              'assets/icon/delete_icon.png'),
                                                          color:
                                                              Color(0xff2D2D2D),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 140.0,
                                            // width: 500,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://app.ramagyasportsacademy.com/members_image/${data[index]["image"]}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 70,
                                              color: const Color(0xffFFFFFF),
                                              child: Center(
                                                child: Container(
                                                  height: 150,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          bottom: 20,
                                                          right: 10,
                                                          top: 10),
                                                  child: TextFormField(
                                                    controller:
                                                        descriptionController![
                                                            index],
                                                    onChanged: ((value) {
                                                      description = value;
                                                      print(
                                                          'descriptionvalueprint: $description');
                                                    }),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff2D2D2D)),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: const Color(
                                                                      0xff2D2D2D)
                                                                  .withOpacity(
                                                                      .2)),
                                                        ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                            0xffFFFFFF),
                                                        hintText:
                                                            'Describe this photo',
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                                color: const Color(
                                                                    0xff2D2D2D),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                        suffixIcon: IconButton(
                                                            icon:
                                                                const ImageIcon(
                                                              AssetImage(
                                                                  'assets/icon/send_icon.png'),
                                                              color: Color(
                                                                  0xff2D2D2D),
                                                            ),
                                                            color: Colors.white,
                                                            onPressed:
                                                                () async {
                                                              var feeddata;
                                                              _descriptionPost(
                                                                  Id,
                                                                  description) async {
                                                                SharedPreferences
                                                                    pref =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                print(pref
                                                                    .getString(
                                                                        "description"));
                                                                print(
                                                                    "description$description");
                                                                ApiService.DescriptionUpload(
                                                                        Id,
                                                                        description,
                                                                        pref.getString(
                                                                            "token"))
                                                                    .then(
                                                                        (value) {
                                                                  var des =
                                                                      value;
                                                                  print(
                                                                      "descriptionStatus${des["success"]}");
                                                                  return showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        Future.delayed(
                                                                            const Duration(seconds: 3),
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          const FitnessDairyGallery();
                                                                        });
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                              const Color(0xffC7DFBC),
                                                                          content:
                                                                              Text(
                                                                            "Description send successfully",
                                                                            // "${value["message"]}",
                                                                            style:
                                                                                GoogleFonts.roboto(color: const Color(0xffFFFFFF), fontSize: 13),
                                                                          ),
                                                                        );
                                                                      });
                                                                });
                                                              }

                                                              setState(() {
                                                                _descriptionPost(
                                                                    data[index]
                                                                        ["id"],
                                                                    description);
                                                                print(
                                                                    "descriptionprint");
                                                                print(
                                                                    description);
                                                              });
                                                            })),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]);
                            }),
              ],
            ),
          ),
        ));
  }
}
