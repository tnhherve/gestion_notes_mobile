
import 'package:gestion_notes/models/user.dart';
import 'package:gestion_notes/services/api_manager.dart';
import 'package:get/get.dart';


class UserController extends GetxController{
  var user = User().obs;

  void connectUser() async {

    var  token= await API_Manager.getToken();
    // getToken();
    print(token);
    User userConnect = await API_Manager().getUser(token);
    if (userConnect != null){
      user = userConnect.obs;
      print(user.value.email);

    }
    // Get.put(UserController());
    // return null;
  }

  // void getToken() async{
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectUser();

  }
}


