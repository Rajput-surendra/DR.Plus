import 'dart:convert';
import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/controllers/verify_screen_controller.dart';
import 'package:dr_plus/route_management/routes.dart';
import 'package:dr_plus/services/api_methods.dart';
import 'package:dr_plus/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/verify_otp_model.dart';
import '../booking/booking_appointment.dart';


class VerifyOtpScreen extends StatefulWidget {

  final otp; final mobile;
  const VerifyOtpScreen({Key? key,this.otp,this.mobile}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  TextEditingController pinController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 50,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 30, 30, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(100),
    ),
  );

  String? userId;
  VerifyOtpModel? verifyOtpModel;
  verifyOtpNew() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=8493ab1e62f4c7466bc379bc02c1c8b0d42ad42e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.verifyOtp}'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finaResult = VerifyOtpModel.fromJson(jsonDecode(result));
       verifyOtpModel =finaResult;
       userId =  verifyOtpModel?.data?[0].id ?? "";
       preferences.setString('user_id', userId!);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BookingAppointment()));
    }
    else {
    print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: VerifyScreenController(),
      builder: (controller) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 70.0, right: 50),
              child: Text('Verification'),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        AppColors.secondary.withOpacity(0.1),
                        AppColors.secondary
                      ])),
            ),
            leading: InkWell(
                onTap: () {
                  Get.back();

                },
                child: const Icon(Icons.arrow_back_ios)),
            actions: const [],
          ),
          backgroundColor: AppColors.whit,

          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Code has sent to",
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Text(
                    "+91${widget.mobile}",
                    style: TextStyle(color:  AppColors.black,fontWeight:FontWeight.w500,fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                  SizedBox(height: 20,),
                  Center(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Directionality(
                            // Specify direction if desired
                            textDirection: TextDirection.ltr,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                              child:Pinput(
                                length: 6,
                                controller: pinController,
                                defaultPinTheme: defaultPinTheme,

                                validator: (s) {
                                  return s == '${widget.otp}' ? null : 'Please enter correct OTP';
                                },
                                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) => print(pin),
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  const Text("Haven't received the verification code?",style: TextStyle(
                      color: AppColors.black,fontSize: 15,fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                    onTap: (){
                      loginwitMobile();
                    },

                    child: const Text("Resend",style: TextStyle(
                        color: AppColors.secondary,fontWeight: FontWeight.bold,fontSize: 17
                    ),),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: (){
                      if(pinController.text== widget.otp){
                        verifyOtpNew();
                      }else{
                        Fluttertoast.showToast(
                            msg: "Please fill OTP field ",
                          backgroundColor: AppColors.secondary
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Submit OTP",style: TextStyle(color: AppColors.whit,fontSize: 16),)),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      );
    },);
  }
  bool isloader = false;
  loginwitMobile() async {
    setState(() {
      isloader =  true;
    });
    var headers = {
      'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.getLogin}'));
    request.fields.addAll({
      'mobile': widget.mobile,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);

      if (jsonresponse['error'] == false) {
        String? otp = jsonresponse["otp"];
        String mobile = jsonresponse["mobile"];
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor:  AppColors.secondary);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyOtpScreen(otp: otp.toString(),mobile:mobile.toString() ,)
            ));


      }
      else{
        Fluttertoast.showToast(msg: "${jsonresponse['message']}",backgroundColor:  AppColors.secondary);
        setState(() {
          isloader = false;
        });
      }

    }
    else {
      setState(() {
        isloader = false;
      });
      print(response.reasonPhrase);
    }

  }
}

