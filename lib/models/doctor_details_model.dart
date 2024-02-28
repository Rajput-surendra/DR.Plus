import 'dart:convert';

/// status : true
/// message : "Doctors lists"
/// data : [{"id":"361","ip_address":null,"category_id":null,"company_name":null,"company_division":"12","designation_id":null,"title":"Mr.","gender":"Male","username":"Yogesh","password":"$2y$10$kumnpO8TkRqLhF5pN6FVn.qV8duYYK2MQJEt.SgnSPLRCyGg2qcj.","email":"yogesh282@gmail.com","mobile":"7878118988","image":"https://drplusapp.in/assets/no-image.png","balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":"1684509857","active":"1","company":null,"address":"alphawizz","c_address":"alphawizz","doc_digree":"MBBS","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":"9001","roll":"1","city":"Indore","area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"cGoi3_RqQaW3FkZA1nRs_T:APA91bEw1dsfWCb5BqaBAeVpr1xsSqdz-BKZoLnjp5g0rQ8J2ActoHyApwvjziDvfw5K0rPO0rVWlBb7DAKrjCXb4pA8NJEMBStYI-uODz8GeA0Ll6gjHN0m56Y3x2GnzSl0YusaT64F","device_token":null,"latitude":null,"longitude":null,"created_at":"2023-05-19 11:13:47","state_id":"11","city_id":"283","area_id":"1","experience":"7 Years","place_name":"Vijay Nagar Indore","city_name":"Indore","state_name":"MADHYA PRADESH","clinics":[{"id":"11","user_id":"361","day":"Sun,Tue,Sat","clinic_name":"Hospital 1","morning_shift":"10 to 12 PM","evening_shift":"06 to 09 PM","addresses":"701/1 Yashwant pride, Opp Mc donald cake, near Dmart2","appoint_number":"9234567822","created_at":"2023-05-19 11:13:47","updated_at":"2023-05-19 11:13:47"},{"id":"12","user_id":"361","day":"Sun,Tue,Sat","clinic_name":"Hospital 1","morning_shift":"10 to 12 PM","evening_shift":"06 to 09 PM","addresses":"701/1 Yashwant pride, Opp Mc donald cake, near Dmart2","appoint_number":"9234567822","created_at":"2023-05-19 11:13:47","updated_at":"2023-05-19 11:13:47"}],"is_favorite":true},{"id":"348","ip_address":null,"category_id":null,"company_name":null,"company_division":"12","designation_id":null,"title":"Mr.","gender":"Male","username":"Yogesh","password":"$2y$10$ql6QqUeLxRjLhJYh6qHk/encvUJAJ1xCLUxO95l5/.z0WVKA6kDu2","email":"yogesh182@gmail.com","mobile":"7878818988","image":"https://drplusapp.in/assets/no-image.png","balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":null,"active":"0","company":null,"address":"alphawizz","c_address":"alphawizz","doc_digree":"MBBS","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":"7699","roll":"1","city":"Indore","area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"dP2D406NTJyk8ydDJFi4D3:APA91bEg1hIOnQmW0JWqCVXFisUYts7Ih7MShqlNu9tJ0CjrWcxqM3lvietMcxiUV-pOgjHWw92X4VobfzQBOr-VPtNc2DWxsTU7pVDaQLYPo216MRpu8L_1-poGijjfQOzcXntjlpd1","device_token":null,"latitude":null,"longitude":null,"created_at":"2023-05-18 18:01:58","state_id":"11","city_id":"283","area_id":"1","experience":"7 Years","place_name":"Vijay Nagar Indore","city_name":"Indore","state_name":"MADHYA PRADESH","clinics":[{"id":"9","user_id":"348","day":"Sun,Tue,Sat","clinic_name":"Hospital 1","morning_shift":"10 to 12 PM","evening_shift":"06 to 09 PM","addresses":"701/1 Yashwant pride, Opp Mc donald cake, near Dmart2","appoint_number":"9234567822","created_at":"2023-05-18 18:01:58","updated_at":"2023-05-18 18:01:58"},{"id":"10","user_id":"348","day":"Sun,Tue,Sat","clinic_name":"Hospital 1","morning_shift":"10 to 12 PM","evening_shift":"06 to 09 PM","addresses":"701/1 Yashwant pride, Opp Mc donald cake, near Dmart2","appoint_number":"9234567822","created_at":"2023-05-18 18:01:58","updated_at":"2023-05-18 18:01:58"}],"is_favorite":false}]
DoctorDetailsResponseModel doctorDetailsResponseModelFromJson(String str) => DoctorDetailsResponseModel.fromJson(json.decode(str));

String doctorListResponseModelToJson(DoctorDetailsResponseModel data) => json.encode(data.toJson());
class DoctorDetailsResponseModel {
  bool? status;
  String? message;
  List<DoctorDetailsData>? data;

  DoctorDetailsResponseModel({this.status, this.message, this.data});

  DoctorDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorDetailsData {
  String? id;

  String? companyDivision;
  String? title;
  String? gender;
  String? username;
  String? password;
  String? email;
  String? mobile;
  String? image;
  String? balance;

  String? createdOn;
  String? lastLogin;
  String? active;

  String? address;
  String? cAddress;
  String? docDigree;
  String? bonusType;

  String? cashReceived;
  String? otp;
  String? roll;
  String? city;

  String? fcmId;

  String? createdAt;
  String? stateId;
  String? cityId;
  String? areaId;
  String? experience;
  String? placeName;
  String? cityName;
  String? stateName;
  List<Clinic>? clinic;
  bool? isFavorite;
  bool? isSelected;
  bool? isSubcrction;

  DoctorDetailsData(
      {this.id,
        this.isSelected,

        this.companyDivision,

        this.title,
        this.gender,
        this.username,
        this.password,
        this.email,
        this.mobile,
        this.image,
        this.balance,

        this.createdOn,
        this.lastLogin,
        this.active,

        this.address,
        this.cAddress,
        this.docDigree,
        this.bonusType,

        this.cashReceived,

        this.otp,
        this.roll,
        this.city,

        this.fcmId,

        this.createdAt,
        this.stateId,
        this.cityId,
        this.areaId,
        this.experience,
        this.placeName,
        this.cityName,
        this.stateName,
        this.clinic,
        this.isSubcrction,
        this.isFavorite
      });

  DoctorDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSelected: false;

    companyDivision = json['company_division'];

    title = json['title'];
    gender = json['gender'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    balance = json['balance'];

    createdOn = json['created_on'];
    lastLogin = json['last_login'];
    active = json['active'];

    address = json['address'];
    cAddress = json['c_address'];
    docDigree = json['doc_digree'];
    bonusType = json['bonus_type'];

    cashReceived = json['cash_received'];
    otp = json['otp'];
    roll = json['roll'];
    city = json['city'];


    fcmId = json['fcm_id'];

    createdAt = json['created_at'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    experience = json['experience'];
    placeName = json['place_name'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    if (json['clinics'] != null) {
      clinic = <Clinic>[];
      json['clinics'].forEach((v) {
        clinic!.add(new Clinic.fromJson(v));
      });
    }
    isFavorite = json['is_favorite'];
    isSubcrction = json['is_plan_purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data ["isSelected"] = this .isSelected;

    data['company_division'] = this.companyDivision;

    data['title'] = this.title;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['balance'] = this.balance;

    data['created_on'] = this.createdOn;
    data['last_login'] = this.lastLogin;
    data['active'] = this.active;

    data['address'] = this.address;
    data['c_address'] = this.cAddress;
    data['doc_digree'] = this.docDigree;
    data['bonus_type'] = this.bonusType;

    data['cash_received'] = this.cashReceived;


    data['otp'] = this.otp;
    data['roll'] = this.roll;
    data['city'] = this.city;

    data['fcm_id'] = this.fcmId;

    data['created_at'] = this.createdAt;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['experience'] = this.experience;
    data['place_name'] = this.placeName;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    if (this.clinic != null) {
      data['clinics'] = this.clinic!.map((v) => v.toJson()).toList();
    }
    data['is_favorite'] = this.isFavorite;
    return data;
  }
}

class Clinic {
  String? id;
  String? userId;
  String? day;
  String? clinicName;
  String? morningShift;
  String? eveningShift;
  String? addresses;
  String? appointNumber;
  String? createdAt;
  String? updatedAt;

  Clinic(
      {this.id,
        this.userId,
        this.day,
        this.clinicName,
        this.morningShift,
        this.eveningShift,
        this.addresses,
        this.appointNumber,
        this.createdAt,
        this.updatedAt});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    day = json['day'];
    clinicName = json['clinic_name'];
    morningShift = json['morning_shift'];
    eveningShift = json['evening_shift'];
    addresses = json['addresses'];
    appointNumber = json['appoint_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['day'] = this.day;
    data['clinic_name'] = this.clinicName;
    data['morning_shift'] = this.morningShift;
    data['evening_shift'] = this.eveningShift;
    data['addresses'] = this.addresses;
    data['appoint_number'] = this.appointNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
