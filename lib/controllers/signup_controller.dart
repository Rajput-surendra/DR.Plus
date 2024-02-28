
import 'package:dr_plus/models/get_place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/get_cities_model.dart';
import '../models/get_state_model.dart';
import '../route_management/routes.dart';
import '../services/request_keys.dart';
import '../widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class SignupController extends AppBaseController {

  String? selectedState;
  String? selectedCity;
  String? selectedPlace;


  int? selectedSateIndex ;

  void onTapHome() {
    Get.toNamed(homeScreen);
  }

  List<Map<String, dynamic>> item = [
    {'icon': 'assets/images/imageIcon1.png', 'statename': 'State'},
    {'icon': 'assets/images/imageIcon2.png', 'statename': 'City'},
    {'icon': 'assets/images/imageIcon3.png', 'statename': 'Place'}
  ];
  String? dropdownValue;


  final List<String> items = [
    'Andhra Pradesh(Amaravati)',
    'Assam(Dispur)',
    'Bihar(Patna)',
    'Chhattisgarh(Raipur)',
    'Uttar Pradesh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  final TextEditingController textEditingController = TextEditingController();


  RxBool isLoading = false.obs;

  List <GetStateData> getStateData = [];

 // String? id;

  Future<void> chooseState() async {
    isLoading.value = true;
    try {
      Map<String, String> body = {};
      GetStateResponseModel res = await api.StateGateData(body);
      print('${res.status}');
      if (res.status ?? true) {
        getStateData = res.data ?? [];
        print('This is categories of State ${getStateData}');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        ShowMessage.showSnackBar('Error', "Something Went Wrong ");
      }
    } catch (error) {
      ShowMessage.showSnackBar('Error', "${error}");
    }
  }

  String? placeName;
  String? id;
  String? cityId;
  String? placeID;
  List <GetCitiesData>getCitiesData = [];

  Future<void> chooseCities(String id) async {
    isLoading.value = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.state_id]=id;
      GetCitiesResponseModel res = await api.citiesGateData(body);
      if (res.status ?? true) {

        getCitiesData = res.data ?? [];


        print('This is categories ${getCitiesData}');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        ShowMessage.showSnackBar('Error', "Something Went Wrong ");
      }
    } catch (error) {
      ShowMessage.showSnackBar('Error', "${error}");
    }
  }




  List <GetPlacedData>getPlacedData = [];

  Future<void> choosePlaced(String cityId) async {
    print('MYYYYYYYYYYYYYYYY${selectedPlace}');
    isLoading.value = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.cityId]=cityId;
      GetPlaceResponseModel res = await api.placesGateData(body);
      if (res.status ?? true) {
        getPlacedData = res.data ?? [];
        print('This is categories ${getPlacedData}');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        ShowMessage.showSnackBar('Error', "Something Went Wrong ");
      }
    } catch (error) {
      ShowMessage.showSnackBar('Error', "${error}");
    }
  }

  void placeIdLoop(){
    getPlacedData.forEach((element) {
      if(selectedPlace == element.name) {
        placeID = element.id;
      }
      
    });
  }





  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    chooseState();

  }



}



