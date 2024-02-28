class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String get_banner = 'get_banners';
  String get_categories = 'get_categories';
  String getDoctors = 'get_doctors';
  String GetDoctors = 'get_doctors';
  String getStates = 'get_states';
  String getCities = 'get_cities';
  String getPlace = 'get_places';
  String getLogin = 'login';
  String verifyOtp = 'verify_user';
  String bookAppointment = 'book_appointment';
  String bookings = 'bookings';




}
 const imageUrl = 'https://drplusapp.in/';
class ApiEndPoint{

  static const baseAppUrl = 'https://drplusapp.in/user/app/v1/api/';

  static const String getLogin = baseAppUrl +'login';
  static const String verifyOtp = baseAppUrl +'verify_user';
  static const String bookAppointment = baseAppUrl +'book_appointment';
  static const String bookings = baseAppUrl +'bookings';
  static const String bookingsCancel = baseAppUrl+'cancel_booking';
  static const String get_banner = baseAppUrl+ 'get_banners';
  static const String get_categories = baseAppUrl+'get_categories';
  static const String getDoctors = baseAppUrl+'get_doctors';
  static const String GetDoctors = baseAppUrl+  'get_doctors';
  static const String getStates = baseAppUrl+ 'get_states';
  static const String getCities = baseAppUrl+ 'get_cities';
  static const String getPlace = baseAppUrl+ 'get_places';
  static const String wishListApi = baseAppUrl+ 'get_wishlist';
  static const String bookingApi = baseAppUrl+ 'get_places';
  static const String awarenessApi = baseAppUrl+ 'doctor_awareness';


}