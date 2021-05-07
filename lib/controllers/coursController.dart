import 'package:gestion_notes/models/cours.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class CoursController extends GetxController{
  var coursList = Cours().obs;

  void fetchUserCourses() async {
    Cours cours = await API_Manager().getUserCourses();
    if (cours != null){
      coursList = cours.obs;
      print(cours.data);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserCourses();
  }
}

