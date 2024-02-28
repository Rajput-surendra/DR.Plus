import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../views/signup_view/signup_view.dart';



class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashController() );
      Get.lazyPut(() => const SignUpScreen());
     //

  }


}