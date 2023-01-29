// To parse this JSON data, do
//
//     final myProgress = myProgressFromJson(jsonString);

import 'dart:convert';

// MyProgressModel myProgressFromJson(String str) =>
//     MyProgressModel.fromJson(json.decode(str));

// String myProgressToJson(MyProgressModel data) => json.encode(data.toJson());

// class MyProgressModel {
//   MyProgressModel({this.success, this.message, this.data, s});

//   bool? success;
//   String? message;
//   List<MyProgressModel>? data;

//   factory MyProgressModel.fromJson(Map<String, dynamic> json) =>
//       MyProgressModel(
//         success: json["success"],
//         message: json["message"],
//         data: List<MyProgressModel>.from(json["data"].map((x) => MyProgressModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

class MyProgressModel {
  MyProgressModel({
    this.name,
    this.value,
    this.unit,
  });

  String? name;
  String? value;
  String? unit;

  factory MyProgressModel.fromJson(Map<String, dynamic> json) =>
      MyProgressModel(
        name: json["name"],
        value: json["value"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "unit": unit,
      };
}
