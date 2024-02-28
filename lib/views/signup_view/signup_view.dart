import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/controllers/signup_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;




    return GetBuilder(
      init: SignupController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Do you want to go back?'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
            return shouldPop!;
          },
          child: Scaffold(
            backgroundColor: AppColors.lightwhit,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: heightSize / 8,
                      width: widthSize / 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.primary, AppColors.secondary],
                            stops: [0, 1]),
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Image.asset(
                          'assets/images/dr_plus_logo.png',
                          scale: 15,
                        ),
                      ))),
                  Container(
                      width: widthSize / 1,
                      height: heightSize / 4.7,
                      child: Image.asset(
                        'assets/images/banner1.png',
                        fit: BoxFit.fill,
                      )),
                  Container(
                    height: heightSize /2,
                    width: widthSize,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.asset('assets/images/imageIcon1.png', scale: 1.7,
                                    )),
                                const SizedBox(width: 5,),
                                Container(
                                  width: widthSize/1.76,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      hint: const Text('State',
                                        style: TextStyle(
                                            color: AppColors.secondary,fontWeight: FontWeight.w500,fontSize:16
                                        ),),
                                      // dropdownColor: colors.primary,
                                      value: controller.selectedState,
                                      icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.secondary,size: 30,),
                                      // elevation: 16,
                                      style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                                      underline: Container(
                                        // height: 2,
                                        color:  AppColors.whit,
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          controller.selectedState = value!;
                                        controller.getStateData.forEach((element) {
                                       if(element.name == value){
                                         controller.selectedSateIndex = controller.getStateData.indexOf(element);
                                          controller.id = element.id;

                                          controller.selectedCity = null;
                                          controller.selectedPlace = null;

                                          controller.chooseCities(controller.id!);
                                          controller.update();
                                         }
                                        });
                                        });
                                      },
                                      items: controller.getStateData.map((items) {
                                        return DropdownMenuItem(
                                          value: items.name.toString(),
                                          child:  Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height:15,),
                                              Container(
                                                  width: 130,
                                                  child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.secondary,fontWeight: FontWeight.w600),)),
                                              const SizedBox(height:1,),
                                              const Divider(
                                                thickness: 0.2,
                                                color: AppColors.primary,
                                              ),

                                            ],
                                          ),
                                        );
                                      })
                                          .toList(),

                                    ),

                                  ),
                                ),
                               ]
                                ),

                    ),

                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.asset('assets/images/imageIcon2.png',
                                      scale: 1.7,
                                    )),
                                const SizedBox(
                                  width:5,
                                ),


                                Container(
                                  width: widthSize/1.76,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      hint: const Text('City',
                                        style: TextStyle(
                                            color: AppColors.secondary,fontWeight: FontWeight.w500,fontSize:16
                                        ),),
                                      // dropdownColor: colors.primary,
                                      value: controller.selectedCity,
                                      icon:  const Padding(
                                        padding: EdgeInsets.only(left:10.0),
                                        child: Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.secondary,size: 30,),
                                      ),
                                      // elevation: 16,
                                      style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                                      underline: Padding(
                                        padding: const EdgeInsets.only(left: 0,right: 0),
                                        child: Container(
                                          // height: 2,
                                          color:  AppColors.whit,
                                        ),
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          controller.selectedCity = value!;
                                          controller.getCitiesData.forEach((element) {
                                            if(element.name == value){
                                              controller.selectedSateIndex =  controller.getCitiesData.indexOf(element);
                                              controller.cityId = element.id;
                                              controller.selectedPlace = null;
                                              controller.choosePlaced(controller.cityId!);
                                              controller.update();
                                            }
                                          });

                                        });
                                      },

                                      items: controller.getCitiesData.map((items) {
                                        return DropdownMenuItem(
                                          value: items.name.toString(),
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 15),
                                                child: Container(
                                                    width: 130,
                                                    child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.secondary,fontWeight: FontWeight.w600),)),
                                              ),
                                              const Divider(
                                                thickness: 0.2,
                                                color: AppColors.primary,
                                              )
                                            ],
                                          ),

                                        );
                                      })
                                          .toList(),

                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 55,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.asset('assets/images/imageIcon3.png',
                                      scale: 1.7,
                                    )),
                                const SizedBox(
                                  width:5,
                                ),

                                Container(
                                  width: widthSize/1.72,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      hint: const Text('Place',
                                        style: TextStyle(
                                            color: AppColors.secondary,fontWeight: FontWeight.w500,fontSize:16
                                        ),),
                                      // dropdownColor: colors.primary,
                                      value: controller.selectedPlace,
                                      icon:  const Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.secondary,size: 30,),
                                      ),
                                      // elevation: 16,
                                      style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                                      underline: Padding(
                                        padding: const EdgeInsets.only(left: 0,right: 0),
                                        child: Container(
                                          // height: 2,
                                          color:  AppColors.whit,
                                        ),
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          controller.selectedPlace = value!;
                                          controller.placeIdLoop();
                                        });

                                      },

                                      items: controller.getPlacedData.map((items) {
                                        return DropdownMenuItem(
                                          value: items.name.toString(),
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5),
                                                child: Container(
                                                    width: 130,
                                                    child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.secondary,fontWeight: FontWeight.w600),)),
                                              ),
                                              const Divider(
                                                thickness: 0.2,
                                                color: AppColors.primary,
                                              )
                                            ],
                                          ),

                                        );
                                      })
                                          .toList(),

                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomAppBtn(
                            height: 55,
                            width: widthSize / 1.5,
                            title: 'Submit',
                            onPress: () {

                              if( controller.selectedState == null ||controller.selectedCity==null){
                                Fluttertoast.showToast(msg: 'Please select all fields',backgroundColor:  AppColors.secondary);
                              }
                              else{
                                controller.onTapHome();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


