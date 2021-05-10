
import 'package:gestion_notes/models/evaluation.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';

class EvaluationController extends GetxController{

  var evaluations = EvaluationResponse().obs;

  void getEvaluationsCours(int id) async{
    EvaluationResponse evaluationResponse = await API_Manager().getEvaluationsCours(id);
    if (evaluationResponse != null){
      evaluations = evaluationResponse.obs;
      print(evaluationResponse);
    }
  }

}