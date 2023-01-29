import 'dart:convert';

class FitnessdiaryModel {
  // Object? description;

  FitnessdiaryModel({this.Id
      // this.description,

      });
  int? Id;
  String? description;

  factory FitnessdiaryModel.fromJson(Map<String, dynamic> json) =>
      FitnessdiaryModel(
        Id: json["id"],
        // description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": Id,
        "description": description,
      };
}
