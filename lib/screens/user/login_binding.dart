
import 'package:get/get.dart';
import 'package:zpfmsnew/constant/provider/api.dart';
import 'package:zpfmsnew/screens/user/login_controller.dart';
import '../../../constant/repository/api_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
