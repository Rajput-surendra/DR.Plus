// To parse this JSON data, do
//
//     final getCategoriesResponseModel = getCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetCategoriesResponseModel getCategoriesResponseModelFromJson(String str) => GetCategoriesResponseModel.fromJson(json.decode(str));

String getCategoriesResponseModelToJson(GetCategoriesResponseModel data) => json.encode(data.toJson());

class GetCategoriesResponseModel {
  bool? status;
  String? message;
  List<getCategoriesData>? data;

  GetCategoriesResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) => GetCategoriesResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<getCategoriesData>.from(json["data"].map((x) => getCategoriesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class getCategoriesData {
  String? id;
  String? name;
  String? parentId;
  String? slug;
  String? image;
  String? banner;
  String? rowOrder;
  String? status;
  String? catType;
  String? clicks;

  getCategoriesData({
    this.id,
    this.name,
    this.parentId,
    this.slug,
    this.image,
    this.banner,
    this.rowOrder,
    this.status,
    this.catType,
    this.clicks,
  });

  factory getCategoriesData.fromJson(Map<String, dynamic> json) => getCategoriesData(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    slug: json["slug"],
    image: json["image"],
    banner: json["banner"],
    rowOrder: json["row_order"],
    status: json["status"],
    catType: json["cat_type"],
    clicks: json["clicks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "slug": slug,
    "image": image,
    "banner": banner,
    "row_order": rowOrder,
    "status": status,
    "cat_type": catType,
    "clicks": clicks,
  };
}
