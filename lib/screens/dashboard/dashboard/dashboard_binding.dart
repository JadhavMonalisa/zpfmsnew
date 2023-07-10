
import 'package:get/get.dart';
import 'package:zpfmsnew/constant/provider/api.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_controller.dart';
import '../../../constant/repository/api_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
