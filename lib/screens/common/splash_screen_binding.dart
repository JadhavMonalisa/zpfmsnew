
import 'package:get/get.dart';
import 'package:zpfmsnew/constant/provider/api.dart';
import '../../../constant/repository/api_repository.dart';
import 'splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
