import 'package:dr_plus/controllers/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init:SearchController(),
      builder: (controller) {
      return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.zero,
                height: 100,
                width:widthSize/1,
                decoration:const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[AppColors.primary,AppColors.secondary])),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                    Container(
                      height: 50,
                      width: widthSize/1.1,
                      child: Card(
                      elevation: 5,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,color: AppColors.secondary,),
                            hintText: 'Search',hintStyle: TextStyle(color: AppColors.secondary)
                        ),
                      ),
                  ),
                    ),
                    ],
                  ),
              ),
              ListView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 45),
                itemBuilder: (context, index) {
                  return Container(
                    height: heightSize/5,
                    width: widthSize/2,
                   //padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Card(
                      elevation: 3,
                      child: Row(
                        children: [
                          Container(
                              height: 100,
                              width: 120,
                              child: Image.asset(controller.sliderList[index]['image'])),
                          SizedBox(width:1,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text(controller.sliderList[index]['name'],style: const TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: AppColors.primary),),
                              const SizedBox(height: 5,),
                              Text(controller.sliderList[index]['profession'],style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.secondary)),
                              const SizedBox(height: 5,),
                              Text(controller.sliderList[index]['address'],style: const TextStyle(fontSize:12,fontWeight: FontWeight.w600)),
                              const SizedBox(height: 5,),
                              Text(controller.sliderList[index]['experience'],style: const TextStyle(fontSize:12,fontWeight: FontWeight.w600)),
                              const SizedBox(height:5,),
                              Row(children: [
                                Image.asset(controller.items[index]['icon'],height: 20,width:20,),
                                const SizedBox(height:5,),
                                Text(controller.items[index]['State'],style: const TextStyle(fontSize: 12),),
                                const SizedBox(height:5,),
                                Image.asset(controller.items[index]['icon1'],height: 20,width: 20,),
                                const SizedBox(height:5,),
                                Text(controller.items[index]['City'],style: const TextStyle(fontSize: 12)),
                                const SizedBox(height:5,),
                                Image.asset(controller.items[index]['icon2'],height: 20,width: 20,),
                                const SizedBox(height:5,),
                                Text(controller.items[index]['Place'],style: const TextStyle(fontSize: 12)),
                              ],)
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },),
            ],
          ),
        ),
      );
    },);
  }
}
