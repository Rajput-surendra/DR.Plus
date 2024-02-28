

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dr_plus/Services/api_methods.dart';
import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/controllers/home_controller.dart';
import 'package:dr_plus/views/signup_view/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../models/Slider_model.dart';
import '../Notification/notification_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: HomeController(),
      builder:(controller) {
      return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text("Are you sure you want to exit?."),
                actions: <Widget>[
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: AppColors.primary),
                    child: const Text("YES"),
                    onPressed: () {
                      controller.onTapSignupScreen();
                     // exit(0);
                      // SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: AppColors.primary),
                    child: const Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
         // key: controller.scaffoldKey,
          backgroundColor: AppColors.lightwhit,
          appBar: AppBar(

            centerTitle: true,
              flexibleSpace: Container(
                decoration:BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[AppColors.secondary.withOpacity(0.1),AppColors.secondary])),
              ),
             title: InkWell(
               onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
               },
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [

                     Icon(Icons.search),
                     controller.signupController.selectedPlace == null ?
                     Text('${controller.signupController.selectedCity}'
                       ,style: const TextStyle(fontWeight: FontWeight.w400,fontSize:16),)
                         :Text('${controller.signupController.selectedPlace}',style: const TextStyle(fontWeight: FontWeight.w400,fontSize:16),)
                   ],
                 )),
            actions: [
              Image.asset("assets/images/dr_plus_logo.png",height: 50,width: 50,),
              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.notifications_active,size: 30,),
                  ))
            ],

          ),
          drawer: controller.getDrawer(),
          //drawer: controller.scaffoldKey.currentState!.openDrawer(),
          body:sliderModel ==  null ?Center(child: CircularProgressIndicator()): controller.isBusy ? const Center(child: CircularProgressIndicator(color: AppColors.secondary,),) : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:15,),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search here'),
                    onChanged: (value) {
                      controller.searchProduct(value);
                    },
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15,),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              onPageChanged: (index, result) {
                                controller.currentPost1 = index;
                                controller.update();
                              },
                              viewportFraction: 1.0,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 500),
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                              height: 180.0),

                          items:sliderModel?.data?.map((val) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    height: heightSize/4.6,
                                    width: widthSize/1,
                                    child:Image.network("${val.image}",fit: BoxFit.cover,));
                              },
                            );
                          }).toList(),

                        ),
                        const SizedBox(height:10,),
                        Positioned(
                          bottom: 20,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.buildDots1(),),
                          ),
                        ),
                      ],
                    ),
                const SizedBox(height: 20,),
                SizedBox(
                  // height: heightSize/0.7,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.categoryList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:4,
                      mainAxisSpacing:5,
                        mainAxisExtent: 120
                      ),
                    itemBuilder:(context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.getSliderData1 ();
                                controller.onTapDoctorList(index);
                              },
                              child: Container(
                                height:70,
                                width: 70,
                                decoration: BoxDecoration(
                                    gradient:const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[AppColors.secondary,AppColors.primary]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child:Image.network(controller.categoryList[index].image??'',scale:1.5,)
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              width: 91,
                                child: Text(controller.categoryList[index].name??'',
                                  style:TextStyle(fontSize: 10,fontWeight: FontWeight.w500),overflow: TextOverflow.visible,maxLines: 2,textAlign: TextAlign.center,)),
                          ],
                        );

                      },),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      );
    },);
  }
  int currentPost1 =  0;
  buildDots1() {
    List<Widget> dots = [];
    for (int i = 0; i < (sliderModel?.data?.length  ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(1.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPost1 == i
                ? AppColors.secondary
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      );
      // update();

    }
    return dots;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
  }
  SliderModel? sliderModel;
getSliderApi() async {
  var headers = {
    'Cookie': 'ci_session=71a0342822031edd42e19b3ef0b0ffa877251dc5'
  };
  var request = http.MultipartRequest('GET', Uri.parse('${ApiEndPoint.get_banner}'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult = SliderModel.fromJson(jsonDecode(result));
     setState(() {
       sliderModel =  finalResult;
     });
  }
  else {
  print(response.reasonPhrase);
  }

}
}


