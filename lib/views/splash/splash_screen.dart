
import 'package:dr_plus/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
      return Container(
        height: heightSize,
        width: widthSize,
        color: AppColors.primary,
        child: Image.asset('assets/images/dr_plus_logo.png',scale:4.3,),
      );
    },) ;
  }
}



