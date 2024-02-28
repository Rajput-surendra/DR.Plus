
import 'dart:async';

import 'package:dr_plus/route_management/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'appbased_controller/appbase_controller.dart';

class SplashController extends AppBaseController {

  Future<void> onInit() async {
    // TODO: implement onInit
      Timer( const Duration(seconds: 3),(){
        Get.offNamed(singUpScreen);
      });
      super.onInit();
    // TODO: implement initState

  }


}