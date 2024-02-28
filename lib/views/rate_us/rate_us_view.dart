import 'package:dr_plus/controllers/rate_us_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({Key? key}) : super(key: key);

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:RateUsController(),
      builder:(controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 50.0,right: 50),
            child: Text('Rate Us'),
          ),
          flexibleSpace: Container(
            decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[AppColors.secondary.withOpacity(0.1),AppColors.secondary])),
          ),
          leading:InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios)),
          actions: const [
          ],
        ),
      );

    },);
  }
}
