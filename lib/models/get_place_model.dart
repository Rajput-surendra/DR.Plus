// To parse this JSON data, do
//
//     final getPlaceResponseModel = getPlaceResponseModelFromJson(jsonString);

import 'dart:convert';

GetPlaceResponseModel getPlaceResponseModelFromJson(String str) => GetPlaceResponseModel.fromJson(json.decode(str));

String getPlaceResponseModelToJson(GetPlaceResponseModel data) => json.encode(data.toJson());

class GetPlaceResponseModel {
  bool? status;
  String? message;
  List<GetPlacedData>? data;

  GetPlaceResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetPlaceResponseModel.fromJson(Map<String, dynamic> json) => GetPlaceResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<GetPlacedData>.from(json["data"].map((x) => GetPlacedData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetPlacedData {
  String? id;
  String? name;
  String? cityId;
  String? zipcodeId;
  String? minimumFreeDeliveryOrderAmount;
  String? deliveryCharges;

  GetPlacedData({
    this.id,
    this.name,
    this.cityId,
    this.zipcodeId,
    this.minimumFreeDeliveryOrderAmount,
    this.deliveryCharges,
  });

  factory GetPlacedData.fromJson(Map<String, dynamic> json) => GetPlacedData(
    id: json["id"],
    name: json["name"],
    cityId: json["city_id"],
    zipcodeId: json["zipcode_id"],
    minimumFreeDeliveryOrderAmount: json["minimum_free_delivery_order_amount"],
    deliveryCharges: json["delivery_charges"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city_id": cityId,
    "zipcode_id": zipcodeId,
    "minimum_free_delivery_order_amount": minimumFreeDeliveryOrderAmount,
    "delivery_charges": deliveryCharges,
  };
}
