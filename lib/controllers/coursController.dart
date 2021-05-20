import 'package:gestion_notes/models/cours.dart';
import 'package:gestion_notes/models/ponderation.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class CoursController extends GetxController{

  var coursList = CoursResponse().obs;
  var pond = Ponderation().obs;

  void getSumPonderation(int id) async {
    Ponderation ponderation = await API_Manager().getSumPonderationCours(id);
    if(ponderation!=null){
      pond = ponderation.obs;
      print(pond);
    }
  }

  void fetchUserCourses() async {
    CoursResponse cours = await API_Manager().getUserCourses();
    if (cours != null){
      coursList = cours.obs;
      print(cours.data);

    }
  }

  Future<bool> addCours(String nomC, String section, double seuil) async {
    bool cours = await API_Manager().addCours(nomC, section, seuil);
    if (cours){
     await fetchUserCourses();
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

      return true;
    }
    else
      return false;

  }

  @override
  void onInit() {
    update();
    // TODO: implement onInit
    super.onInit();
    fetchUserCourses();

  }
}

