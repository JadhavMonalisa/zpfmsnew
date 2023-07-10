
import 'package:get/get.dart';
import 'package:zpfmsnew/screens/common/profile.dart';
import 'package:zpfmsnew/screens/common/splash_screen_binding.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_binding.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_screen.dart';
import 'package:zpfmsnew/screens/dashboard/payment/2. payment_long_data.dart';
import 'package:zpfmsnew/screens/dashboard/payment/1. payment_short_data.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/1. enter_data_from_photo_upload.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/2. search_work_order_list.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/4. before_after_photo_upload.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/3. bill_details_from_photo_upload.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/5.%20uploaded_photo_screen.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/6.%20view_photo.dart';
import 'package:zpfmsnew/screens/dashboard/track_bill/1. enter_data_from_track_bill.dart';
import 'package:zpfmsnew/screens/dashboard/track_bill/2. track_bill_list.dart';
import 'package:zpfmsnew/screens/dashboard/common/2.%20bill_details_from_work_order.dart';
import 'package:zpfmsnew/screens/dashboard/common/3.%20track_bill_from_work_order.dart';
import 'package:zpfmsnew/screens/dashboard/work_order/1. work_order_list.dart';
import 'package:zpfmsnew/screens/user/login_binding.dart';
import 'package:zpfmsnew/screens/common/splash_screen.dart';
import 'package:zpfmsnew/screens/user/login_screen.dart';
import 'package:zpfmsnew/screens/user/mobile_no.dart';
import 'package:zpfmsnew/screens/user/otp_screen.dart';
import 'package:zpfmsnew/screens/user/set_password_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.defaultRoute;

  static final all = [
    GetPage(
      name: AppRoutes.defaultRoute,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    ///user basics
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.mobileNoScreen,
      page: () => const MobileNoScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      page: () => const EnterOtpScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.setPasswordScreen,
      page: () => const SetPasswordScreen(),
      binding: LoginBinding(),
    ),
    ///Home screen
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    ///Work order
    GetPage(
      name: AppRoutes.workOrder,
      page: () => const WorkOrderListScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.billDetailsFromWorkOrder,
      page: () => const BillDetailsFromWorkOrder(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.trackBillFromWorkOrder,
      page: () => const TrackBillFromWorkOrder(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentShortDataScreen,
      page: () => const PaymentShortDataScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentLongDataScreen,
      page: () => const PaymentLongDataScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.trackBillList,
      page: () => const TrackBillList(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.enterDataFromTrackBill,
      page: () => const EnterManuallyForTrackBill(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.enterDataScreenFromPhotoUpload,
      page: () => const EnterDataScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.searchWorkOrderList,
      page: () => const SearchWorkOrderList(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.billDetailsFromPhotoUpload,
      page: () => const BillDetailsFromPhotoUploadScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.beforeAfterPhotoUpload,
      page: () => const BeforeAfterPhotoUpload(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadedPhotoScreen,
      page: () => const UploadedPhotoScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.viewPhotoScreen,
      page: () => const ViewPhotoScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => const Profile(),
      binding: DashboardBinding(),
    ),
  ];
}
