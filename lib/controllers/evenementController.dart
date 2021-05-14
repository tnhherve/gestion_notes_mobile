
import 'package:gestion_notes/models/evenement.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class EvenementController extends GetxController{

  var evenements = EvenementResponse().obs;

  void getEvenementUser() async{
    EvenementResponse event = await API_Manager().getEvenementUser();
    if(event != null){
      evenements = event.obs;
      print(evenements);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEvenementUser();
  }
}