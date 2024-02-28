import 'dart:convert';

import 'package:dr_plus/services/apiService.dart';
import 'package:dr_plus/services/api_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;

import '../../Services/api_methods.dart';
import '../../Utils/colors.dart';
import '../../models/Get_awreness_model.dart';

class AwrenessScreen extends StatefulWidget {
  const AwrenessScreen({Key? key}) : super(key: key);

  @override
  State<AwrenessScreen> createState() => _AwrenessScreenState();
}

class _AwrenessScreenState extends State<AwrenessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAwarenessListApi();
  }
  GetAwrenessModel? getAwrenessModel;
  getAwarenessListApi() async {
    var headers = {
      'Cookie': 'ci_session=cdbd346aeb637d4f574b95b7476f4f6c0be73896'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.doctorAwareness}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalResult =  GetAwrenessModel.fromJson(jsonDecode(result));
    print('___Divya_______${finalResult}_________');
    setState(() {
      getAwrenessModel =  finalResult;

    });
    }
    else {
    print(response.reasonPhrase);
    }

  }

int? selected = 0;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Awareness '),
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

      ),
      body:
      getAwrenessModel?.data == null ? Center(child: CircularProgressIndicator()):  getAwrenessModel?.data?.length == 0 ?Text("No Awareness"): Container(
        height: MediaQuery.of(context).size.height/1,
        child: ListView.builder(
          key: Key('builder ${selected.toString()}'),
          itemCount:getAwrenessModel?.data?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  border: Border.all(color: AppColors.black)
                ),
                child: ExpansionTile(

                  textColor: AppColors.black,
                  iconColor: AppColors.black,
                  collapsedTextColor: AppColors.whit,
                  collapsedIconColor: AppColors.whit,
                  collapsedBackgroundColor: AppColors.secondary,
                      key:  Key(index.toString()),
                      initiallyExpanded: index == selected ,
                  title: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("${getAwrenessModel?.data?[index].icon}",fit: BoxFit.fill,))),
                              SizedBox(width: 5,),
                              Text('${getAwrenessModel?.data?[index].title}'),
                    ],
                  ),
                  onExpansionChanged: (isExpanded) {

                        if(isExpanded) {
                          setState(()  {
                          const Duration(milliseconds: 2000);
                            selected = index;
                          });

                        }else{
                          setState(() {
                            selected = -1;
                          });

                        }


                  },
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                          height: 100,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Image.network("${getAwrenessModel?.data?[index].image}",fit: BoxFit.fill,))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 350,
                          child: Text("${getAwrenessModel!.data![index].description}",overflow: TextOverflow.ellipsis,maxLines: 10,style: TextStyle(color: AppColors.black),)),
                    )

                  ],
                ),

              ),

            );

          },

        ),
      ),
    );
  }

}


