
import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class AppBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  AppBtn({Key? key, this.title, this.onPress, this.height, this.width, this.fSize, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0 ,
            backgroundColor:AppColors.secondary,
            shape: const StadiumBorder(),
            fixedSize: Size(width!, height!)
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title',
              style: const TextStyle(
                fontSize: 18,
                //fSize ,
                fontWeight: FontWeight.w500,
                color:Colors.white,
              ),),
            icon!=  null ?  Icon(icon,
              size: 18,)
                : const SizedBox.shrink()
          ],
        ));
  }
}
