/// error : false
/// message : "All Notifications"
/// data : [{"id":"3","title":"Booking request","message":"Booking request sent successfully","type":"","type_id":"","send_to":null,"users_id":"668","image":null,"date_sent":"2023-08-16 19:36:33"}]

  class GetNotificationModel {
  GetNotificationModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetNotificationModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetNotificationModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetNotificationModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// title : "Booking request"
/// message : "Booking request sent successfully"
/// type : ""
/// type_id : ""
/// send_to : null
/// users_id : "668"
/// image : null
/// date_sent : "2023-08-16 19:36:33"

class Data {
  Data({
      String? id, 
      String? title, 
      String? message, 
      String? type, 
      String? typeId, 
      dynamic sendTo, 
      String? usersId, 
      dynamic image, 
      String? dateSent,}){
    _id = id;
    _title = title;
    _message = message;
    _type = type;
    _typeId = typeId;
    _sendTo = sendTo;
    _usersId = usersId;
    _image = image;
    _dateSent = dateSent;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _message = json['message'];
    _type = json['type'];
    _typeId = json['type_id'];
    _sendTo = json['send_to'];
    _usersId = json['users_id'];
    _image = json['image'];
    _dateSent = json['date_sent'];
  }
  String? _id;
  String? _title;
  String? _message;
  String? _type;
  String? _typeId;
  dynamic _sendTo;
  String? _usersId;
  dynamic _image;
  String? _dateSent;
Data copyWith({  String? id,
  String? title,
  String? message,
  String? type,
  String? typeId,
  dynamic sendTo,
  String? usersId,
  dynamic image,
  String? dateSent,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  message: message ?? _message,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  sendTo: sendTo ?? _sendTo,
  usersId: usersId ?? _usersId,
  image: image ?? _image,
  dateSent: dateSent ?? _dateSent,
);
  String? get id => _id;
  String? get title => _title;
  String? get message => _message;
  String? get type => _type;
  String? get typeId => _typeId;
  dynamic get sendTo => _sendTo;
  String? get usersId => _usersId;
  dynamic get image => _image;
  String? get dateSent => _dateSent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['message'] = _message;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['send_to'] = _sendTo;
    map['users_id'] = _usersId;
    map['image'] = _image;
    map['date_sent'] = _dateSent;
    return map;
  }

}