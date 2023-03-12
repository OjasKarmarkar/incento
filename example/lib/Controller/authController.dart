import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:incento_demo/Models/common_response.dart';
import 'package:incento_demo/Screens/Mainscreen/main_screen.dart';
import 'package:incento_demo/Utils/data_source.dart';
import 'package:incento_demo/Utils/helper.dart';

class AuthController extends GetxController {
  void login(String email, String pwd) {
    // DataSource.login({"email": email, "password": pwd},
    //     successCompletion: (CommonResponse cp) {
    //   print("logged in");
    //   GetStorage().write('uid', email);
      Get.off(() => const MainScreen());
    // }, errCompletion: (CommonResponse cp) {
    //   showSnackbar('Error', cp.message ?? "Unknown error");
    // });
  }
}
