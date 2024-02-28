import 'package:dr_plus/controllers/doctor_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import '../booking/booking_appointment.dart';
import '../login/LoginScreen.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  List<String> dayList = ["Sun", "Mon", "Tue","Wed","thur","Fri","Sat"];

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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getUserData();
  }
  @override
  Widget build(BuildContext context) {

    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: DoctorDetailsController(),
      builder: (controller) {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Scaffold(

          bottomSheet: controller.doctorDetailsData.isEmpty  ? Center(child: CircularProgressIndicator()) : InkWell(
            onTap: (){
              print("this is ne wuser ID $userId");
              if(userId == null || userId == ''){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }else{
                print('____Som___ffffffffffff___${controller.doctorDetailsData[0]}_________');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingAppointment(doctorDetailsData: controller.doctorDetailsData[0],)));
              }
            },
            child:
            controller.doctorDetailsData.isEmpty ? Center(child: CircularProgressIndicator()):
            controller.doctorDetailsData.isNotEmpty && controller.doctorDetailsData.first.isSubcrction == true ? Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,bottom: 10,top: 10),
              child: Container(
                height: 35,

                decoration: BoxDecoration(color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Booking",style: TextStyle(color:AppColors.whit),)),
              ),
            ):SizedBox()
          ),

          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 62.0,right: 50),
              child: Text('Doctor Details',style: TextStyle(fontSize:18,fontWeight: FontWeight.w700),),
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
          body:controller.doctorDetailsData.isEmpty ? Center(child: CircularProgressIndicator()):SingleChildScrollView(
            child:
            Column(
              children: [
                SizedBox(height:20,),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical:110),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //const Text('Life & Care Clinic',style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Container(
                                  child:ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => Divider(
                                      height: 30,
                                      indent: 10,
                                       endIndent: 10,
                                      color:Colors.grey.withOpacity(0.4)
                                    ),
                                    itemCount: controller.doctorDetailsData.first.clinic!.length,
                                    itemBuilder: (context, index) {
                                      String isContain = controller.doctorDetailsData.first.clinic![index].day.toString();
                                      print('__________${isContain.contains('SAT')}_________');
                                      print('__________${controller.doctorDetailsData.first.clinic![index].day}_________');
                                      return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Text("${controller.doctorDetailsData.first.clinic![index].clinicName}"
                                            ,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                          Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color:AppColors.secondary2,
                                                borderRadius:BorderRadius.circular(3)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10.0,right: 10),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:  [
                                                    Container(
                                                        child: Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                          color: isContain.contains('SUN') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Sun',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('MON') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Mon',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('TUE') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Tue',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('WED') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Wed',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('THU') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Thur',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('FRI') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Fri',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),
                                                    Container(
                                                        child: Container(
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                color: isContain.contains('SAT') ? AppColors.primary : Colors.transparent),
                                                            height: 30,
                                                            width: 40,
                                                            child: Center(child: const Text('Sat',style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500,fontSize: 13),)))),

                                                  ]),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20
                                            ),
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child:Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                                  children: [
                                                    Row(
                                                        children:  [
                                                          const Icon(Icons.watch_later_outlined,size: 20,),
                                                          const SizedBox(width: 5,),
                                                          Text('Morning : ${controller.doctorDetailsData.first.clinic![index].morningShift}',style: TextStyle(fontSize: 9,fontWeight: FontWeight.w700  ,color: AppColors.black)),
                                                        ]),
                                                    Row(
                                                        children:[
                                                      const Icon(Icons.watch_later_outlined,size: 20,),
                                                      SizedBox(width: 5,),
                                                      Text('Evening : ${controller.doctorDetailsData.first.clinic![index].eveningShift}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 9))
                                                    ]
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              Image.asset('assets/images/locationImage.png',color:AppColors.red,height:15,width:15,),
                                              Text("${controller.doctorDetailsData.first.clinic![index].addresses}")
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    );
                                    },
                                  )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                   // controller.isBusy ? const Center(child: CircularProgressIndicator(),):
                    Container(
                      height: 142,
                      padding: EdgeInsets.symmetric(horizontal:8,),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 3,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  height: 80,
                                  width: 80,
                                  child:controller.doctorDetailsData[0].image== null || controller.doctorDetailsData[0].image== " "?Image.asset('assets/images/doctor4') :
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                      child: Image.network('${controller.doctorDetailsData[0].image}'))),
                            ),
                            SizedBox(width:5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${controller.doctorDetailsData[0].title}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: AppColors.primary)),
                                    Text('${controller.doctorDetailsData[0].username}',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: AppColors.primary),),
                                  ],
                                ),
                                Text('+91${controller.doctorDetailsData[0].mobile}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600)),
                                const SizedBox(height: 5,),
                               // const Text('Consultant Dermatology',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.secondary)),
                                Text('${controller.doctorDetailsData[0].docDigree}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600)),
                                const SizedBox(height: 5,),
                                Text('${controller.doctorDetailsData[0].companyDivision}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600)),
                                const SizedBox(height: 5,),
                                Text('${controller.doctorDetailsData[0].experience} Year',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600)),
                                const SizedBox(height:5,),
                                Row(children: [
                                  Image.asset('assets/Icons/placeicon.png',height: 15,width:15,),
                                  const SizedBox(width: 3,),
                                  Container(
                                    width: 80,
                                      child: Text('${controller.doctorDetailsData[0].placeName}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                                  const SizedBox(width: 3,),
                                  Image.asset('assets/Icons/cityicon.png',height: 15,width: 15,),
                                  const SizedBox(width: 3,),
                                  Container(
                                      width: 40,
                                      child: Text('${controller.doctorDetailsData[0].cityName}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                                  const SizedBox(width: 3,),
                                  Image.asset('assets/Icons/state_icon.png',height: 15,width: 15,),
                                  const SizedBox(width:3,),
                                  Container(
                                      width: 60,
                                      child: Text('${controller.doctorDetailsData[0].stateName}',style: TextStyle(fontSize:13,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                                ],)
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),

                  ],
                ),



              ],
            ),
          ),
        ),
      );
    },);
  }
}
