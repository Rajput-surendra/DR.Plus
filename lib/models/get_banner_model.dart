// To parse this JSON data, do
//
//     final getBannerResponseModel = getBannerResponseModelFromJson(jsonString);

import 'dart:convert';

GetBannerResponseModel getBannerResponseModelFromJson(String str) => GetBannerResponseModel.fromJson(json.decode(str));

String getBannerResponseModelToJson(GetBannerResponseModel data) => json.encode(data.toJson());

class GetBannerResponseModel {
  bool? status;
  String? message;
  List<getBannerData>? data;

  GetBannerResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetBannerResponseModel.fromJson(Map<String, dynamic> json) => GetBannerResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<getBannerData>.from(json["data"].map((x) => getBannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class getBannerData {
  String? id;
  String? type;
  String? typeId;
  String? companyId;
  String? image;
  String? video;
  String? slider;
  dynamic link;
  DateTime? dateAdded;

  getBannerData({
    this.id,
    this.type,
    this.typeId,
    this.companyId,
    this.image,
    this.video,
    this.slider,
    this.link,
    this.dateAdded,
  });

  factory getBannerData.fromJson(Map<String, dynamic> json) => getBannerData(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    companyId: json["company_id"],
    image: json["image"],
    video: json["video"],
    slider: json["slider"],
    link: json["link"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "company_id": companyId,
    "image": image,
    "video": video,
    "slider": slider,
    "link": link,
    "date_added": dateAdded!.toIso8601String(),
  };
}
