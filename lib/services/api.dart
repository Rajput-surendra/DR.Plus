
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dr_plus/models/doctor_details_model.dart';
import 'package:dr_plus/models/get_banner_model.dart';
import 'package:dr_plus/models/get_categories_data.dart';
import 'package:dr_plus/models/get_place_model.dart';
import 'package:dr_plus/models/get_state_model.dart';
import 'package:flutter/foundation.dart';


import '../models/doctor_list_response.dart';
import '../models/get_cities_model.dart';
import 'api_client.dart';
import 'api_methods.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();

final Connectivity connectivity = Connectivity();

  //final Connectivity? connectivity;

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> getHeader() {
    return {'Cookie': 'ci_session=c35fa031f74710f20bf26fea3b4ccd7bfe18332a'};
    // return {'Content-Type': 'application/json'};
  }

  Future<GetBannerResponseModel> SliderApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.get_banner,body:body);
      if (res.isNotEmpty) {
        try {
          return getBannerResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetBannerResponseModel(status:false);
        }
      } else {
        return GetBannerResponseModel(status:false);
      }
    } else {
      return GetBannerResponseModel(status:false);
    }
  }

  Future<GetCategoriesResponseModel> homeCategories(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.get_categories);
      if (res.isNotEmpty) {
        try {
          return getCategoriesResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCategoriesResponseModel(status:false);
        }
      } else {
        return GetCategoriesResponseModel(status:false);
      }
    } else {
      return GetCategoriesResponseModel(status:false);
    }
  }

  Future<DoctorListResponseModel>getDoctor(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getDoctors, body: body);

      if (res.isNotEmpty) {
        try {
          return doctorListResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DoctorListResponseModel(status:true);
        }
      } else {
        return DoctorListResponseModel(status:false);
      }
    } else {
      return DoctorListResponseModel(status:false);
    }
  }


  Future<DoctorDetailsResponseModel>getDoctorDetails(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.GetDoctors, body: body);
      if (res.isNotEmpty) {
        try {
          return doctorDetailsResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DoctorDetailsResponseModel(status:true);
        }
      } else {
        return DoctorDetailsResponseModel(status:false);
      }
    } else {
      return DoctorDetailsResponseModel(status:false);
    }
  }

  Future<GetStateResponseModel>StateGateData(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getStates);
      if (res.isNotEmpty) {
        try {
          return getStateResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetStateResponseModel(status:true);
        }
      } else {
        return GetStateResponseModel(status:false);
      }
    } else {
      return GetStateResponseModel(status:false);
    }
  }

  Future<GetCitiesResponseModel>citiesGateData(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getCities, body:body);
      if (res.isNotEmpty) {
        try {
          return getCitiesResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode){
            print(e);
          }
          return GetCitiesResponseModel(status:true);
        }
      } else {
        return GetCitiesResponseModel(status:false);
      }
    } else {
      return GetCitiesResponseModel(status:false);
    }
  }

  Future<GetPlaceResponseModel>placesGateData(body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getPlace, body:body);
      if (res.isNotEmpty) {
        try {
          return getPlaceResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetPlaceResponseModel(status:true);
        }
      } else {
        return GetPlaceResponseModel(status:false);
      }
    } else {
      return GetPlaceResponseModel(status:false);
    }
  }



}