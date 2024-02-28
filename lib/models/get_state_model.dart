// To parse this JSON data, do
//
//     final getStateResponseModel = getStateResponseModelFromJson(jsonString);

import 'dart:convert';

GetStateResponseModel getStateResponseModelFromJson(String str) => GetStateResponseModel.fromJson(json.decode(str));

String getStateResponseModelToJson(GetStateResponseModel data) => json.encode(data.toJson());

class GetStateResponseModel {
  bool? status;
  String? message;
  List<GetStateData>? data;

  GetStateResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetStateResponseModel.fromJson(Map<String, dynamic> json) => GetStateResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<GetStateData>.from(json["data"].map((x) => GetStateData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetStateData {
  String? id;
  String? name;
  String? countryId;

  GetStateData({
    this.id,
    this.name,
    this.countryId,
  });

  factory GetStateData.fromJson(Map<String, dynamic> json) => GetStateData(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}
