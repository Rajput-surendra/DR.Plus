/// error : false
/// message : "Booking Cancelled Successfull"

class BookingCencelModel {
  BookingCencelModel({
      bool? error, 
      String? message,}){
    _error = error;
    _message = message;
}

  BookingCencelModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
  }
  bool? _error;
  String? _message;
BookingCencelModel copyWith({  bool? error,
  String? message,
}) => BookingCencelModel(  error: error ?? _error,
  message: message ?? _message,
);
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}