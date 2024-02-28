/// error : false
/// message : "Doctor Awareness"
/// data : [{"id":"6","title":"Allergist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:23:02","updated_at":"2023-07-26 17:43:41","is_collapsed":true},{"id":"7","title":"Dentist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:22:50","updated_at":"2023-07-26 17:43:41","is_collapsed":true},{"id":"8","title":"Anaesthesiologist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:22:36","updated_at":"2023-07-26 17:43:41","is_collapsed":true},{"id":"9","title":"Dermatologist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:22:19","updated_at":"2023-07-26 17:43:41","is_collapsed":true},{"id":"11","title":"Cardiologist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf 1","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:22:01","updated_at":"2023-07-26 17:43:41","is_collapsed":true},{"id":"12","title":"Endocrinologist","description":"Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf","image":"https://drplusapp.in/uploads/media/2023/Group_4.png","icon":"https://drplusapp.in/uploads/media/2023/Group_4.png","created_at":"2023-07-28 17:21:37","updated_at":"2023-07-26 17:43:41","is_collapsed":true}]

class GetAwrenessModel {
  GetAwrenessModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetAwrenessModel.fromJson(dynamic json) {
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
GetAwrenessModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetAwrenessModel(  error: error ?? _error,
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

/// id : "6"
/// title : "Allergist"
/// description : "Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf"
/// image : "https://drplusapp.in/uploads/media/2023/Group_4.png"
/// icon : "https://drplusapp.in/uploads/media/2023/Group_4.png"
/// created_at : "2023-07-28 17:23:02"
/// updated_at : "2023-07-26 17:43:41"
/// is_collapsed : true

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? image, 
      String? icon, 
      String? createdAt, 
      String? updatedAt,
      bool? isExpaind
      }){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _icon = icon;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    isExpaind =  isExpaind;

}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _icon = json['icon'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
     isExpaind = false;


  }
  String? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _icon;
  String? _createdAt;
  String? _updatedAt;
  bool?   isExpaind;

Data copyWith({  String? id,
  String? title,
  String? description,
  String? image,
  String? icon,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  icon: icon ?? _icon,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,


);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get icon => _icon;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['icon'] = _icon;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;

    return map;
  }

}