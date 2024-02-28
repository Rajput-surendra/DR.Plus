import 'package:dr_plus/controllers/appbased_controller/appbase_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../models/doctor_details_model.dart';
import '../services/request_keys.dart';
import '../widgets/show_message.dart';

class DoctorDetailsController extends AppBaseController{

  int? selectedDays=0;
  String? docId;
  @override
  void onInit() {
    // TODO: implement onInit
    docId = Get.arguments ;
    DetailsData();
    super.onInit();
  }

  List <DoctorDetailsData> doctorDetailsData = [] ;
  Future<void> DetailsData () async{
    isBusy = true ;
    update();
    try{
      Map<String, String> body = {};
      body[RequestKeys.docId] = docId.toString();
      DoctorDetailsResponseModel res  = await api.getDoctorDetails(body) ;
      if(res.status??false){
        doctorDetailsData = res.data??[];
        isBusy = true ;
        update();
      }else {
        isBusy = true ;
        update();
        ShowMessage.showSnackBar('Error',"Something went wrong") ;
      }

    }catch(error) {
      ShowMessage.showSnackBar('Error',"${error}") ;
    }


  }



}