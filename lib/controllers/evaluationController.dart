
import 'package:gestion_notes/controllers/coursController.dart';
import 'package:gestion_notes/models/evaluation.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class EvaluationController extends GetxController{
  CoursController _coursController = Get.put(CoursController());
  var evaluations = EvaluationResponse().obs;

  void getEvaluationsCours(int id) async{
    EvaluationResponse evaluationResponse = await API_Manager().getEvaluationsCours(id);
    if (evaluationResponse != null){
      evaluations = evaluationResponse.obs;
      print(evaluationResponse);
    }
  }

  Future<bool> addEvaluation(String titre, double note, double ponderation, String dateE, int typeE, int coursId) async{

    bool eval = await API_Manager().addEvaluation(titre, note, ponderation, dateE, typeE, coursId);
    if(eval){
      getEvaluationsCours(_coursController.coursList.value.data[0].id);
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
    getEvaluationsCours(_coursController.coursList.value.data[0].id);
  }

}