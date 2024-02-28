/// error : false
/// message : "Registered Successfully"
/// otp : "562792"
/// data : [{"id":"385","mobile":"9797979797","username":"","email":null}]

class VerifyOtpModel {
  VerifyOtpModel({
      bool? error, 
      String? message, 
      String? otp, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _otp = otp;
    _data = data;
}

  VerifyOtpModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _otp = json['otp'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  String? _otp;
  List<Data>? _data;
VerifyOtpModel copyWith({  bool? error,
  String? message,
  String? otp,
  List<Data>? data,
}) => VerifyOtpModel(  error: error ?? _error,
  message: message ?? _message,
  otp: otp ?? _otp,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  String? get otp => _otp;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['otp'] = _otp;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "385"
/// mobile : "9797979797"
/// username : ""
/// email : null

class Data {
  Data({
      String? id, 
      String? mobile, 
      String? username, 
      dynamic email,}){
    _id = id;
    _mobile = mobile;
    _username = username;
    _email = email;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _mobile = json['mobile'];
    _username = json['username'];
    _email = json['email'];
  }
  String? _id;
  String? _mobile;
  String? _username;
  dynamic _email;
Data copyWith({  String? id,
  String? mobile,
  String? username,
  dynamic email,
}) => Data(  id: id ?? _id,
  mobile: mobile ?? _mobile,
  username: username ?? _username,
  email: email ?? _email,
);
  String? get id => _id;
  String? get mobile => _mobile;
  String? get username => _username;
  dynamic get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mobile'] = _mobile;
    map['username'] = _username;
    map['email'] = _email;
    return map;
  }

}