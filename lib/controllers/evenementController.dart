
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

  Future<bool> addEvent(String nom, String lieu, String dateD, String dateF) async{
    bool response = await API_Manager().addEvent(nom, lieu, dateD, dateF);

    if (response) {
      getEvenementUser();
      update();
      return true;
    }
    else
      return false;
  }

  Future<bool> deleteEvent(int id) async{
    Evenement event = await API_Manager().deleteEvent(id);
    if (event != null){
      evenements.value.data.remove(event.obs.value);
      return true;
    }
    else
      return false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEvenementUser();
  }
}