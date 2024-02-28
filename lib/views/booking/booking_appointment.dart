import 'dart:convert';

import 'package:dr_plus/models/doctor_details_model.dart';
import 'package:dr_plus/services/api_methods.dart';
import 'package:dr_plus/views/booking/BookingDetails.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import '../../models/doctor_list_response.dart';
import 'package:http/http.dart'as http;

class BookingAppointment extends StatefulWidget {
  DoctorDetailsData? doctorDetailsData;
  BookingAppointment({Key? key,this.doctorDetailsData}) : super(key: key);
  @override
  State<BookingAppointment> createState() => _BookingAppointmentState();
}
class _BookingAppointmentState extends State<BookingAppointment> {
  final _formKey = GlobalKey<FormState>();
  bool isloader = false;
  String? userId;
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Clinic? selectedHospital;
  int hospitalIndex = 0;
  getBookAppointmentApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   userId =  preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=9ade101fa6896bd2e6f8453ff6e5202e940ecca7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndPoint.bookAppointment}'));
    request.fields.addAll({
      'user_id':userId.toString(),
      'doctor_id': widget.doctorDetailsData!.id ?? "" ,
      'name': nameController.text,
      'age': ageController.text,
      'description':descriptionController.text,
      'date': dateController.text,
      'time_slot': "${_value}",
      'clinic': "${hospitalIndex}"
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
       //Get.toNamed(homeScreen);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BookingDetails()));
      print('____result______${result}_________');
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor:  AppColors.secondary);
      nameController.clear();
      ageController.clear();
      descriptionController.clear();
      nameController.clear();
      selectedTime = null;
    }

    else {
    print(response.reasonPhrase);
    }
  }
String _dateValue = '';
  var item;
  var dateFormate;
  String selectedDate = '';
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
  String lastselectedDate = '';
  dateDialog(List<String> itemList)async{

    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Dates for appointment",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                const SizedBox(height: 15,),
                Container(
                height: 200,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: itemList.length == 0 ? const Center(child: Text("No date left for appoinment"),) : ListView.builder(
                      itemCount: itemList.length,
                        shrinkWrap: true,
                      itemBuilder: (c,i){
                    return InkWell(
                      onTap: (){
                        setState((){
                          lastselectedDate = itemList[i];
                          dateController.text = itemList[i];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.circle_outlined),
                            const SizedBox(width: 10,),
                            Text("${itemList[i]}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
        );
      });
    });
  }
  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    List<DateTime> selectedDays = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      print("new result here ${endDate.difference(startDate).inDays} and ${startDate.day} and ${startDate.day + i}");
      days.add(
          DateTime(
              startDate.year,
              startDate.month,
              // In Dart you can set more than. 30 days, DateTime will do the trick
              startDate.day + i)
      );
    }

        List<String> dayss = item.toString().toLowerCase().split(",");
        print("list here ${dayss} and ${days}");
        List<String> finaldates = [];
        finaldates.clear();
        DateTime dates = DateTime.now();

    for(var i=0;i<days.length;i++){
      // if(DateFormat('EEE').format(days[i]).contains(dayss))
      if(dayss.contains(DateFormat('EEE').format(days[i]).toString().toLowerCase())){
        if(DateTime.parse(DateFormat('yyyy-MM-dd').format(dates)).isAfter(days[i])){
        }
        else {
          finaldates.add(DateFormat('dd-MM-yyyy').format((days[i])).toString());
        }
      }
      else{
        print("final not working now");
      }
    }
    if(finaldates.isEmpty){
        Fluttertoast.showToast(msg: "No Date Available!!",backgroundColor:  AppColors.secondary);
    }
    else {
      setState(() {
        dateDialog(finaldates);
      });
    }

    return days;
  }
  Future _selectDateStart() async {
    DateTime dates = DateTime.now();
    print("www${findFirstDateOfTheWeek(dates)}");
    print("sfsfsf ${findLastDateOfTheWeek(dates)}");
    getDaysInBeteween(findFirstDateOfTheWeek(dates),findLastDateOfTheWeek(dates));

  }
  TimeOfDay? selectedTime;
  selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      print('_____sfgfdgfdg_____${selectedTime!.format(context)}_________');
    }
  }
  String? doctorListDataClinic;
  List<String> clinics = [];
  Widget MorningShift() {
    return InkWell(
      onTap: () {
        selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              selectedTime != null
                  ? '${selectedTime!.format(context)}'
                  : 'Morning Shift Time',
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      userId =  prefs.getString("user_Id");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();

  }

  int _value = 0;
  bool isStartTime = false;
  bool isEndTime = false;
  bool timeStot = false;
  @override
  Widget build(BuildContext context) {
    print('____Som______${widget.doctorDetailsData?.clinic}_________');
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Booking Appointment'),
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            color: AppColors.whit,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText:"Enter Name",
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height:10,),
                  const Text("Age",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText:"Enter Age",
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height:10,),
                  const Text("Description",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText:"Enter Description",
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  const Text("Select Clinic/Hospital : ",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:Border.all(color: AppColors.black.withOpacity(0.4))
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2 <Clinic>(
                        isExpanded: true,
                        hint:  const Text('Select Clinic/Hospital ',
                          style: TextStyle(
                              color: AppColors.black,fontWeight: FontWeight.normal,fontSize:16
                          ),),
                        // dropdownColor: colors.primary,
                        value: selectedHospital,
                        icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.red,size: 30,),
                        // elevation: 16,
                        style:  const TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),
                        underline: Container(
                          // height: 2,
                          color:  AppColors.whit,
                        ),
                        onChanged: (value) {
                          setState(() {
                            dateController.text = "";
                            timeStot = true;
                            selectedHospital = value;
                            // selectedHospital = value ;
                            hospitalIndex = widget.doctorDetailsData!.clinic!.indexWhere((element) => element.id == value?.id);
                            item =  selectedHospital?.day;
                            print("selected new values ${item}");
                          });
                          print("this is hospital index $hospitalIndex ");
                          // This is called when the user selects an item.
                        },
                        items: widget.doctorDetailsData?.clinic?.map((Clinic items) {
                          return DropdownMenuItem<Clinic>(
                            value: items,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                      width: 250  ,
                                      child: Text(items.clinicName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.black,fontWeight: FontWeight.normal),)),
                                ),


                              ],
                            ),
                          );
                        })
                            .toList(),

                      ),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  hospitalIndex ==  2 ? const SizedBox.shrink():timeStot ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Select Time: ",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          const Text("Morning Shift"),
                          const Text("Evening Shift"),
                        ],),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(
                           children: [
                             Radio(
                               value: 1,
                               fillColor: MaterialStateColor.resolveWith(
                                       (states) =>  AppColors.black),
                               activeColor:  AppColors.black,
                               groupValue: _value,
                               onChanged: (int? value) {
                                 setState(() {
                                   _value = value!;
                                   isStartTime = false;
                                 });
                               },
                             ),
                             Text(
                               "${widget.doctorDetailsData!.clinic![hospitalIndex].morningShift}",
                               style: const TextStyle(
                                 color: AppColors.black ,),
                             ),
                           ],
                         ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  fillColor: MaterialStateColor.resolveWith(
                                          (states) => AppColors.black),
                                  activeColor:   AppColors.black,
                                  groupValue: _value,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value = value!;
                                      isEndTime = true;
                                    });
                                  }),
                              Text(
                                "${widget.doctorDetailsData!.clinic![hospitalIndex].eveningShift}",
                                style: const TextStyle(
                                  color:  AppColors.black,),
                              ),
                            ],
                          )

                        ],
                      ),

                    ],
                  ) :const SizedBox.shrink(),
                  const SizedBox(height:10,),
                  timeStot ? Column(
                    children: [
                      widget.doctorDetailsData!.clinic!.isEmpty ||  widget.doctorDetailsData == "" ? const Center(child: Text("No Days available",style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold),)):
                      Column(
                          children: [
                            Container(
                              height: 25,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(" Available Day:",style: TextStyle(color: AppColors.black,fontSize: 16),),
                                      Text(" ${widget.doctorDetailsData!.clinic?[hospitalIndex].day}",style: const TextStyle(color: AppColors.primary,fontSize: 16),)
                                    ],
                                  )
                                ],
                              ),

                            ),
                            const SizedBox(height: 10,),

                            TextFormField(
                              readOnly: true,
                              onTap: (){
                                _selectDateStart();
                              },
                              controller: dateController,
                              decoration: InputDecoration(
                                  hintText:"Select Date",
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' please select date';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10,),
                          ]
                      ),
                    ],
                  ):const SizedBox.shrink(),

                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          getBookAppointmentApi();
                        }else{
                          Fluttertoast.showToast(msg: "All Field are requerd",backgroundColor:  AppColors.secondary);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(child: Text("Book Now",style: TextStyle(color: AppColors.whit,fontSize: 20),)),
                      ),
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
      )
    );
  }
  int _currentIndex = 1;
  customTabbar(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 1 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              height: 35,
              width: 45,
              child: Center(
                child: Text("SUN",style: TextStyle(color: _currentIndex == 1 ?AppColors.whit:AppColors.black)),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 2;

              });
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2 ?
                    AppColors.primary
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 35,
                width: 45,
                child: Center(
                  child: Text("MON",style: TextStyle(color: _currentIndex == 2 ?AppColors.whit:AppColors.black),),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 3;

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 3 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: 120,
              height: 35,
              width: 45,

              child: Center(
                child: Text("TUE",style: TextStyle(color: _currentIndex == 3 ?AppColors.whit:AppColors.black)),
              ),
            ),
          ),
          const SizedBox(width: 3,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 4;

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 4 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: 120,
              height: 35,
              width: 45,

              child: Center(
                child: Text("WED",style: TextStyle(color: _currentIndex == 4 ?AppColors.whit:AppColors.black)),
              ),
            ),
          ),
          const SizedBox(width: 3,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 5;

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 5 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: 120,
              height: 35,
              width: 45,

              child: Center(
                child: Text("THU",style: TextStyle(color: _currentIndex == 5 ?AppColors.whit:AppColors.black)),
              ),
            ),
          ),
          const SizedBox(width: 3,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 6;

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 6 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: 120,
              height: 35,
              width: 45,

              child: Center(
                child: Text("FRI",style: TextStyle(color: _currentIndex == 6 ?AppColors.whit:AppColors.black)),
              ),
            ),
          ),
          const SizedBox(width: 3,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 7;

              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 7 ?
                  AppColors.primary
                      : AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: 120,
              height: 35,
              width: 45,

              child: Center(
                child: Text("FRI",style: TextStyle(color: _currentIndex == 7 ?AppColors.whit:AppColors.black)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
