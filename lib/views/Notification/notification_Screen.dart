import 'dart:convert';

import 'package:dr_plus/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/colors.dart';
import '../../models/Get_notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  initState() {
   getNotificationApi();
  }
  String? userId;
  GetNotificationModel? getNotificationModel;
  getNotificationApi() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    userId  = preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=68e80f182ab1169d6bb1fda9f2ffac18d518e3bf'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://drplusapp.in/user/app/v1/api/all_notifications'));
    request.fields.addAll({
      'user_id': userId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult = GetNotificationModel.fromJson(jsonDecode(result));
      setState(() {
        getNotificationModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notification List'),
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
      ),
      body: SingleChildScrollView(
        child: getNotificationModel == null ? Center(child: CircularProgressIndicator(color: AppColors.secondary,)) : getNotificationModel!.data!.length  ==  "0"? Text("No Notification List")  :Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getNotificationModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${getNotificationModel!.data?[index].title}"),
                            SizedBox(height: 5,),
                            Text("${getNotificationModel!.data?[index].message}"),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
