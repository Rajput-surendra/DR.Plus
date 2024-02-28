import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Services/api.dart';
class AppBaseController extends GetxController {

 Api api = Api() ;
bool isBusy = false ;
 double width = 0 ;
 double height = 0 ;

 String imageUrl2 = ' ';
 void setBusy(bool value) {
  isBusy = value;
  update();
 }

 double getWidth(BuildContext context){
  return width = MediaQuery.of(context).size.width;
 }
 double getHeight(BuildContext context){
  return height = MediaQuery.of(context).size.height;
 }
 back(){
  Get.back();
 }

}