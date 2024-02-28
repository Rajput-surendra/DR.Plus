import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart'as http;

import '../Utils/colors.dart';

import '../services/apiService.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getSettingApi();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettingApi();
  }
  var privacyPolicy;
  getSettingApi() async {
    var headers = {
      'Cookie': 'ci_session=eb651cdce0850614d296b81363913b2ca08fe641'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getSettings}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      setState(() {
        privacyPolicy = jsonResponse['data']['privacy_policy'][0];
      });

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
        title: const Text('Privacy Policy'),
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
          body: ListView(
            children: [
              privacyPolicy == null ? Center(child: CircularProgressIndicator()) :Html(
                  data:"${privacyPolicy}"
              )
            ],
          )
      ),
    );
  }
}
