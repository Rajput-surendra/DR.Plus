import 'dart:convert';

import 'package:dr_plus/controllers/appbased_controller/appbase_controller.dart';
import 'package:dr_plus/models/Get_wish_list_model.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class wishListController extends AppBaseController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  String ? userId;
  GetWishListModel ? getWishListModel;
getWishListApi() async {
  SharedPreferences  preferences   = await SharedPreferences.getInstance();
   userId = preferences.getString("user_id");

  var headers = {
    'Cookie': 'ci_session=84ac381b0bea62c88d297e89f972727ab7eba30e'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://drplusapp.in/user/app/v1/api/get_wishlist'));
  request.fields.addAll({
    'user_id': userId.toString()
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var result =  await response.stream.bytesToString();
    var finalResult = GetWishListModel.fromJson(jsonDecode(result));
    getWishListModel =  finalResult;
    update();
  }
  else {
  print(response.reasonPhrase);
  }

}

}