import 'dart:convert';

import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/services/api_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import 'VerifyScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  bool isloader = false;
  TextEditingController mobileController = TextEditingController();
  loginwitMobile() async {
    setState(() {
      isloader =  true;
    });
    var headers = {
      'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.getLogin}'));
    request.fields.addAll({
      'mobile': mobileController.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);

      if (jsonresponse['error'] == false) {
        String? otp = jsonresponse["otp"];
        String mobile = jsonresponse["mobile"];
          print('____Som______${otp}_________');
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
@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.75),
                child: Container(
                    height: MediaQuery.of(context).size.height/3.0,
                    child: Image.asset("assets/images/dr_plus_logo.png",scale: 6.2,)),
              ),
              Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: AppColors.whit,
                    // borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                  ),

                  height: MediaQuery.of(context).size.height/1.30,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          const Text("Login",style: TextStyle(color: AppColors.secondary,fontSize: 20),),
                          const SizedBox(height: 50,),
                          Card(
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 4,
                                child: Center(
                                  child: TextFormField(
                                    controller: mobileController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    validator: (v) {
                                      if (v!.length != 10) {
                                        return "mobile number is required";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      counterText: "",
                                      contentPadding:
                                      EdgeInsets.only(left: 15, top: 15),
                                      hintText: "Mobile Number",hintStyle: TextStyle(color: AppColors.secondary),
                                      prefixIcon: Icon(
                                        Icons.call,
                                        color:AppColors.secondary,
                                        size: 20,
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                           SizedBox(height: 90  ,),
                           InkWell(
                             onTap: (){
                               if(_formKey.currentState!.validate()){
                                 loginwitMobile();
                               }else{
                                 Fluttertoast.showToast(msg: "mobile field is requerd",backgroundColor: AppColors.secondary);
                               }
                             },
                             child: Container(
                               height: 50,
                               decoration: BoxDecoration(
                                 color: AppColors.secondary,
                                 borderRadius: BorderRadius.circular(10)
                               ),
                               child: Center(child: isloader ?Center(child: CircularProgressIndicator()) :Text("Send OTP",style: TextStyle(color: AppColors.whit,fontSize: 16),))
                             ),
                           )
                        ],
                      ),
                    ),
                  )

              )

              // Container(
              //   color: colors.primary,
              //   child:
              // )
            ],
          ),
        ),
      ),
    );
  }
}

