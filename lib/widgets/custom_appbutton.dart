import 'package:dr_plus/Utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  CustomAppBtn({Key? key,
    this.title, this.onPress, this.height, this.width, this.fSize, this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            color:AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color:AppColors.secondary)
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            "$title",
            style:  TextStyle(
              color:Colors.white,
              fontSize: fSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );

  }
}