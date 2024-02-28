import 'dart:convert';
import 'package:dr_plus/services/api_methods.dart';
import 'package:dr_plus/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import '../../models/Get_booking_details_model.dart';
import '../../models/booking_cencel_model.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {

  }
  String? userId;
  getUserId() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    userId  = preferences.getString("user_id");
    getBookingDetails();
  }
  GetBookingDetailsModel? getBookingDetailsModel;
  getBookingDetails() async {
    var headers = {
      'Cookie': 'ci_session=9ce8eb13e8d5c2aa354db633884a5ea99e4f1d6e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.bookings}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result =  await response.stream.bytesToString();
     var finalResult =  GetBookingDetailsModel.fromJson(jsonDecode(result));
     setState(() {
       getBookingDetailsModel = finalResult;
     });

    }
    else {
    print(response.reasonPhrase);
    }

  }
  String? id;
  BookingCencelModel? bookingCencelModel;
  cancelBooking() async {
    var headers = {
      'Cookie': 'ci_session=482dbd63865c60a8bf476e30b9deecd8fe5dd001'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.bookingsCancel}'));
    request.fields.addAll({
      'id': '${id}',
      'status':'2'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      getBookingDetails();
      var Response = await response.stream.bytesToString();
      final finalResponse = jsonDecode(Response);
      Fluttertoast.showToast(msg: "${finalResponse['message']}",backgroundColor:  AppColors.secondary);

    }
    else {
    print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Booking Details'),
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
               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Icon(Icons.arrow_back_ios)),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              getBookingDetailsModel == null || getBookingDetailsModel == " "? const Center(child: CircularProgressIndicator()): getBookingDetailsModel!.data!.length == 0 ? Center(child: Text("No data to show"),) :
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: getBookingDetailsModel!.data!.length,
                  itemBuilder:
                      (BuildContext context ,int index){
                    id = getBookingDetailsModel?.data?[index].id;
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal:10,vertical:5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Name :",style: TextStyle(fontWeight: FontWeight.w600),),
                                        const SizedBox(width: 20,),
                                        Text('${getBookingDetailsModel!.data?[index].name}')
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Age : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 30,),
                                        Text('${getBookingDetailsModel!.data?[index].age}')
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Day : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 30,),
                                        Text("${getBookingDetailsModel!.data?[index].day}")
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Date : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width:25,),
                                        Text('${getBookingDetailsModel!.data?[index].date}'),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Time :",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 25,),
                                        Text('${getBookingDetailsModel!.data?[index].timeslotText}')
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text('Description : ',style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width:5,),
                                        Container(
                                            width: 90,
                                            child: Text("${getBookingDetailsModel!.data?[index].description}",overflow: TextOverflow.ellipsis,)),

                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        getBookingDetailsModel!.data![index].statusText == "Accepted" ? Text('Doctor Mobile : ',style: TextStyle(fontWeight: FontWeight.w600)):SizedBox(),
                                        const SizedBox(width:5,),
                                        getBookingDetailsModel!.data![index].statusText == "Accepted" ? Container(
                                            width: 90,
                                            child: Text("${getBookingDetailsModel!.data?[index].doctorMobile}",overflow: TextOverflow.ellipsis,)):SizedBox()

                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("${getBookingDetailsModel!.data![index].statusText}",style: TextStyle(color: AppColors.whit,fontSize:10),)),
                                    ),




                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: (){
                                        cancelBooking();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color:getBookingDetailsModel?.data?[index].statusText=='Cancelled' ? AppColors.whit:AppColors.red,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text("Cancel",style: TextStyle(color: AppColors.whit),)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
          ],),
        )
      ),
    );
  }
}
