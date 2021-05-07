import 'package:gestion_notes/models/cours.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class CoursController extends GetxController{
  var coursList = CoursResponse().obs;

  void fetchUserCourses() async {
    CoursResponse cours = await API_Manager().getUserCourses();
    if (cours != null){
      coursList = cours.obs;
      print(cours.data);
      update();
    }
  }

  Future<bool> addCours(String nomC, String section, String seuil) async {
    Cours cours = await API_Manager().addCours(nomC, section, seuil);
    if (cours != null){
      coursList.value.data.add(cours.obs.value);
      update();
      return true;
    }
    else
      return false;

  }

  Future<bool> deleteCours(int id) async {
    Cours cours = await API_Manager().deleteCours(id);
    if (cours != null){
      coursList.value.data.remove(cours.obs.value);
      update();
      return true;
    }
    else
      return false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserCourses();
    update(coursList.value.data);
  }
}

