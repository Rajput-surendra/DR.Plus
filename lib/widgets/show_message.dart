import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMessage {
  static showSnackBar(String msgTitle, String msg, {Duration? duration}) {
    if (kDebugMode) {

    }
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
          msgTitle,
          msg,
          titleText: Container(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          borderRadius: 4,
          padding: const EdgeInsets.all(14.0),
          margin: EdgeInsets.symmetric(horizontal: Get.width * .01, vertical: Get.height * .01),
          animationDuration: duration

      );
    }
  }
}