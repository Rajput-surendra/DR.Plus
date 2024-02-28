import 'package:dr_plus/route_management/routes.dart';
import 'package:dr_plus/route_management/screen_bindings.dart';
import 'package:dr_plus/views/booking/BookingDetails.dart';
import 'package:dr_plus/views/doctor_details/doctors_details.dart';
import 'package:dr_plus/views/doctor_list_view/doctor_list_view.dart';
import 'package:dr_plus/views/home_view/home_view.dart';
import 'package:dr_plus/views/login/LoginScreen.dart';
import 'package:dr_plus/views/login/VerifyScreen.dart';
import 'package:dr_plus/views/wishList/wishList_Screen.dart';
import 'package:get/get.dart';

import '../Static/privacy_Policy.dart';
import '../Static/terms_condition.dart';
import '../views/Awreness/Awreness.dart';
import '../views/rate_us/rate_us_view.dart';
import '../views/search_view/search_view.dart';
import '../views/signup_view/signup_view.dart';
import '../views/splash/splash_screen.dart';

class AllPages {
  static List<GetPage> getPages() {

    return [
      GetPage(
          name: splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: singUpScreen,
          page: () => const SignUpScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: homeScreen,
          page: () => const HomeScreen()),

      GetPage(
          name: doctorListScreen,
          page: () =>  DoctorListScreen()),

      GetPage(
          name: doctorDetailsScreen,
          page: () => const DoctorDetails()),

      GetPage(
          name: doctorSearchScreen,
          page: () => const SearchScreen()),

      GetPage(
          name: termsConditionScreen,
          page: () => const TermsCondition()),

      GetPage(
          name: privacyPolicyScreen,
          page: () => const PrivacyPolicy()),

      GetPage(
          name: rateUsScreen,
          page: () => const RateUsScreen()),

      GetPage(
          name: loginScreen,
          page: () =>  LoginScreen()),
      GetPage(
          name: wishScreen,
          page: () => WishListScreen()),

      GetPage(
          name: bookingScreen,
          page: () => BookingDetails()),

      GetPage(
          name: verifyScreen,
          page: () =>VerifyOtpScreen()),

      GetPage(
          name: awarenessScreen,
          page: () =>AwrenessScreen()),

    ];
  }
}
