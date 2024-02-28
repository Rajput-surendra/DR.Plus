import 'package:carousel_slider/carousel_slider.dart';
import 'package:dr_plus/controllers/doctorlist_view_controller.dart';
import 'package:dr_plus/views/booking/booking_appointment.dart';
import 'package:dr_plus/views/login/LoginScreen.dart';
import 'package:dr_plus/widgets/commen_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';

class DoctorListScreen extends StatefulWidget {
  // String? doctorId;
  bool? isCatId =false;
  String? areaId,userId;

   DoctorListScreen({Key? key,this.isCatId,this.userId,this.areaId
  }) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String? userId;

  getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      userId =  prefs.getString("user_id");
    });
    print("this is user ID $userId");
  }
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: DoctorListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 70.0, right: 50),
              child: Text('Doctor List'),
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
                child: Icon(Icons.arrow_back_ios)),
            actions: const [],
          ),
          body:

          SingleChildScrollView(
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        )
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                           controller.homeController.getBannerResponseModel?.data==null||
                               controller.homeController.getBannerResponseModel?.data=="" ?
                           Center(child: CircularProgressIndicator()) :
                           controller.homeController.getBannerResponseModel?.data!.length == 0 ?
                           CarouselSlider(
                             options: CarouselOptions(
                                 onPageChanged: (index, result) {
                                   controller.currentPost = index;
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
                                 height: 200.0),
                             items: [1,2,3,4,5].map((i) {
                               return Builder(
                                 builder: (BuildContext context) {
                                   return Image.asset("assets/images/dr_plus_logo.png");


                                 },
                               );
                             }).toList(),

                           )

                           :
                            CarouselSlider(
                              options: CarouselOptions(
                                  onPageChanged: (index, result) {
                                    controller.currentPost = index;
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
                                  height: 200.0),
                              items: controller.homeController.getBannerResponseModel?.data?.map((val) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return  CommonSlider(
                                        file: "${val.image}" ?? '',
                                        link: "${val.link}" ?? '');


                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Positioned(
                              bottom: 20,
                              child: Row(
                                children: controller.buildDots(),
                              ),
                            ),
                          ],
                        ),
                           const SizedBox(
                    height: 10,
                  ),

                  controller.doctorListData == '' ? Center(child: Text("please Wait")):
                  controller.doctorListData.length == 0 ? Center(child: Text("No Doctor List Found!!!")):
                  ListView.builder(
                              itemCount: /*controller.doctorListData == null || controller.doctorListData.length == 0 ?  0 :*/controller.doctorListData.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      controller.onTapDoctorDetails(index);
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                              leading: Container(
                                                  width: 73,
                                                  child: controller.doctorListData[index].image == null || controller.doctorListData[index].image == ""
                                                      ? Image.asset(
                                                          'assets/images/doctor4')
                                                      : ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius.all(Radius.circular(10)),
                                                          child: Image.network(controller.doctorListData[index].image ??
                                                              '',fit: BoxFit.fill,))),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.doctorListData[index]
                                                            .title ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                  Text(
                                                    controller
                                                            .doctorListData[
                                                                index]
                                                            .username ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .docDigree ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondary)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .companyDivision ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .experience ??
                                                              "",
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/Icons/placeicon.png',
                                                            height: 15,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width:40,
                                                              child: Text(controller.doctorListData[index].placeName ?? "",
                                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),maxLines:1, overflow: TextOverflow.ellipsis,
                                                              )),
                                                          Image.asset(
                                                            'assets/Icons/cityicon.png',
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width: 43,
                                                              child: Text(
                                                                  controller
                                                                          .doctorListData[
                                                                              index]
                                                                          .cityName ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis))),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                            'assets/Icons/state_icon.png',
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width: 45,
                                                              child: Text(
                                                                  controller
                                                                          .doctorListData[
                                                                              index]
                                                                          .stateName ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10,),

                                                      SizedBox(height: 10,)
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {

                                                        if (controller.doctorListData[index].isFavorite ==true)
                                                        {
                                                          setState(() {
                                                              controller.getRemoveWishListApi(index);
                                                          });
                                                          controller.doctorData();
                                                        } else {
                                                          setState(() {controller.addWishlistApi(index);// controller.doctorListData[index].isFavorite = ! (controller.doctorListData[index].isFavorite ?? false );
                                                          });
                                                          controller.doctorData();
                                                        }
                                                      },
                                                      icon: controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .isFavorite ==
                                                              true
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color:
                                                                  AppColors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_outline,
                                                              color:
                                                                  AppColors.red,
                                                            )),
                                                  
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ) ,


                ]),
          ),
        );
      },
    );
  }



}
