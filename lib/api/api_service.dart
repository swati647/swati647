// import 'dart:ffi';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rsa_app/FitnessdiaryModel.dart';
import 'dart:convert';
import 'package:rsa_app/MyProgress.dart';
import 'package:rsa_app/body_metrics.dart';
import 'package:rsa_app/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future postRegister(_data) async {
    var body = {
      "mobile": "${_data.phonenumber}",
    };
    var url =
        'https://app.ramagyasportsacademy.com/api/register?mobile=${_data.phonenumber}';
    print(url);
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future otp(_data) async {
    var body = {
      //  "mobile": "${_data.phonenumber}",
      // "otp":"${_data.otp}",
    };
    var url =
        'https://app.ramagyasportsacademy.com/api/login?mobile=${_data.phonenumber}&otp=${_data.otp}';
    print(url);
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future memberships(userId, token) async {
    var body = {"user_id": userId.toString()};
    var url = 'https://app.ramagyasportsacademy.com/api/user-membership';

    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future attendance(userId, token, month) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-attendence?user_id=$userId&month=$month';

    final response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future ClassData(
    token,
    date,
  ) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-classes?date=$date';

    //  var url = 'https://app.ramagyasportsacademy.com/api/user-classes?class_id=224&date=$date';
    print("URLPRINT$url");
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future myclasses(userId, token, date) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/myclasses?user_id=$userId&date=$date';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future plan(
      user_membership_id, userId, userMembershipsId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-Plan?user_id=$userId&user_memberships_id=${user_membership_id}';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future diets(
      user_membership_id, userId, userMembershipsId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-diet?user_id=$userId&user_memberships_id=${user_membership_id}';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future termsConditions(token) async {
    var url = 'https://app.ramagyasportsacademy.com/api/terms-condition';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future privacyPolicy(token) async {
    var url = 'https://app.ramagyasportsacademy.com/api/privacy-policy';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future invoice(membership_id, userId, userMembershipsId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-invoice?user_memberships_id=${membership_id}';
    print("invoiceurl");
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future SportsCategory(token) async {
    var url = 'https://app.ramagyasportsacademy.com/api/sport-category';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future userDetails(userId, token) async {
    var body = {"user_id": userId.toString()};
    var url = 'https://app.ramagyasportsacademy.com/api/user-detail';
    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);
    print("rrrr" + response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future fitnessImageDairy(userId, token, data) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };

    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('https://app.ramagyasportsacademy.com/api/user-fitness'));
    // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    File _file = File(data.path);
    request.fields['user_id'] = userId.toString();
    request.files.add(http.MultipartFile(
        'image', _file.readAsBytes().asStream(), _file.lengthSync(),
        filename: _file.path.split('/').last));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("1_MYRESPONSE_${response.statusCode}");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    return response;
  }

  static Future editProfilePic(
    imageFile,
    userId,
    fullnameController,
    mobileController,
    dobController,
    emailController,
    gender,
    token,
  ) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri =
        Uri.parse("https://app.ramagyasportsacademy.com/api/user-profile-edit");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = http.MultipartFile('profile_pic', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params

    print(userId.toString());
    print(fullnameController.toString());
    print(mobileController.toString());
    print(dobController.toString());
    print(emailController.toString());
    print(gender.toString());

    request.fields['user_id'] = userId.toString();
    request.fields['fullname'] = fullnameController.toString();
    request.fields['mobile'] = mobileController.toString();
    request.fields['dob'] = dobController.toString();
    request.fields['email'] = emailController.toString();
    request.fields['gender'] = gender.toString();

    // request.fields['user_id'] = "224";
    // request.fields['fullname'] = "swati prajapati";
    // request.fields['mobile'] = "8077093176";
    // request.fields['dob'] = "1998-07-06";
    // request.fields['email'] = "Swati@gmail.com";
    // request.fields['gender'] = "0";

    // send
    var response = await request.send();

    print(response.statusCode);
    return response.statusCode;

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print("valuevalue_${value}");
    });
  }

  static Future FitnessImageGet(userId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-fitness-get?user_id=$userId';
    print("descriptionprinturl");
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future BannerImages(userId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/get-banner?user_id=$userId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future BodyMetrics(userId, token) async {
    var url = 'https://app.ramagyasportsacademy.com/api/body-metrics';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future<List<MyProgressModel>?> BodyMetricsData(userId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-metrics?user_id=$userId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );

    print("response.body" + response.body);
    if (response.statusCode == 200) {
      //     MyProgressModel.fromJson(jsonDecode(response.body))
      //         as List<MyProgressModel>;

      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['data'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<MyProgressModel> progress =
          body.map((dynamic item) => MyProgressModel.fromJson(item)).toList();

      return progress;
    }
  }

  static Future Feedbackdata(userId, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-get-feedback?user_id=$userId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future PostFeedbackdata(
      userId, feedbackId, star, comment, token) async {
    // var body = {
    //   "user_id": userId.toString(),
    //   "feedback_id": feedbackId,
    //   "star": star,
    //   "comment": comment.toString()
    // };
    var url =
        'https://app.ramagyasportsacademy.com/api/user-feedback?user_id=$userId&feedback_id=$feedbackId&star=$star&comment=$comment';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      // body: body
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future EditProfilePost(
      userId, profilepic, fullname, email, mobile, dob, gender, token) async {
    var body = {
      "profile_pic": profilepic.toString(),
      "user_id": userId.toString(),
      "fullname": fullname,
      "email": email.toString(),
      "mobile": mobile,
      "dob": dob.toString(),
      "gender": gender.toString()
    };
    var url = 'https://app.ramagyasportsacademy.com/api/user-profile-edit';

    print("hjgsdfbody");
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future Postmetricmyprogress(
      userId,
      bmi,
      weight,
      height,
      boneMass,
      bodyAge,
      protein,
      fatFreeWeight,
      skeletalMuscle,
      muscleMass,
      subcutaneousFat,
      visceralFat,
      bmr,
      bodyWater,
      bodyFat,
      abc,
      token) async {
    var body = {
      "user_id": userId.toString(),
      "BMI_1": bmi,
      "weight_2": weight,
      "Height_3": height,
      "Bone_Mass_4": boneMass,
      "Body_Age_5": bodyAge,
      "Protein_6": protein,
      "Fat_Free_Weight_7": fatFreeWeight,
      "Skeletal_Muscle_8": skeletalMuscle,
      "Muscle_Mass_9": muscleMass,
      "Subcutaneous_Fat_10": subcutaneousFat,
      "Visceral_Fat_11": visceralFat,
      "BMR_12": bmr,
      "Body_Water_13": bodyWater,
      "Body_Fat_14": bodyFat,
      "ABc_15": abc,
    };
    var url = 'https://app.ramagyasportsacademy.com/api/update-metrics';
    // 'https://app.ramagyasportsacademy.com/api/update-metrics?user_id=$userId&BMI_1=$bmi&weight_2=$weight&Height_3=$height&Bone_Mass_4=$boneMass&Body_Age_5=$bodyAge&Protein_6=$protein&Fat_Free_Weight_7=$fatFreeWeight&Skeletal_Muscle_8=$skeletalMuscle&Muscle_Mass_9=$muscleMass&Subcutaneous_Fat_10=$subcutaneousFat&Visceral_Fat_11=$visceralFat&BMR_12=$bmr&Body_Water_13=$bodyWater&Body_Fat_14=$bodyFat&ABc_15=$abc';
    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);
    // print("responsedata");
    print(body);
  }

  static Future FitnessImageDelete(Id, token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url =
        'https://app.ramagyasportsacademy.com/api/user-fitness-delete?id=$Id';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  // static Future DescriptionUpload(Id, description, token) async {
  //   var url =
  //       'https://app.ramagyasportsacademy.com/api/user-fitness-update?id=$Id&description=$description';
  //   print(url);
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Bearer ${token}',
  //     },
  //     // body: body
  //   );

  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     return response.statusCode;
  //   }
  // }

  static Future DescriptionUpload(Id, descriptionController, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/user-fitness-update?id=$Id&description=$descriptionController';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      // body: body
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future QrCode(_scanBarcode, userId, _timeString, token) async {
    var body = {"user_id": userId.toString()};
    var url = '$_scanBarcode?user_id=$userId&time=$_timeString';
    print("QRurldataupload");
    print(url);

    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);
    print("response.bodyprint");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future PtQrCode(membership_id, userId, token) async {
    var body = {
      "user_id": userId.toString(),
      "membership_id": membership_id.toString()
    };
    print("bodydata$body");
    var url =
        'https://app.ramagyasportsacademy.com/api/pt-qrcode?user_id=$userId&memberships_id=${membership_id}';
    print("QRurldataupload");
    print(url);

    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: body);
    print("response.bodyprint");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return response.statusCode;
    }
  }

  static Future AttendanceOndate(userId, cdate, token) async {
    var url =
        'https://app.ramagyasportsacademy.com/api/attendence-ondate?user_id=$userId&date=$cdate';
    print(
        "https://app.ramagyasportsacademy.com/api/attendence-ondate?user_id=$userId&date=$cdate");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return map;
    } else {
      return response.statusCode;
    }
  }
}
