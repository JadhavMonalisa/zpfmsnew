import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zpfmsnew/constant/provider/custom_exception.dart';
import 'package:zpfmsnew/constant/repository/api_repository.dart';
import 'package:zpfmsnew/routes/app_pages.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_model.dart';
import 'package:zpfmsnew/screens/dashboard/payment/payment_model.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/GetViewPhotoModel.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/photo_upload_model.dart';
import 'package:zpfmsnew/screens/dashboard/track_bill/track_bill_model.dart';
import 'package:zpfmsnew/screens/dashboard/work_order/work_order_model.dart';
import 'package:zpfmsnew/utils/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class DashboardController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  DashboardController({required this.repository}) : assert(repository != null);

  String language = "";
  String username = "";
  String token = "";
  List<ContractorDetails> contractorList = [];
  List<PaymentCountList> paymentList = [];
  List<BillDataFromWorkOrderDetails> billDataFromWorkOrderList = [];
  List<TrackBillFromWorkOrderDetails> trackBillFromWorkOrderList = [];
  List<BillDetailsListFromTrackBill> trackBillDetailsList = [];
  //List<PaymentLongListDetails> paymentLongList = [];
  List<WorkOrderSearchDetails> searchWorkOrderList = [];
  List<PhotoUploadedDetailsList> photoUploadedList = [];
  int amount = 0;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();

    username = GetStorage().read("username")??"";
    language = GetStorage().read("language")??"";
    token = GetStorage().read("token")??"";

    update();
    getVersionData();
    Timer(
        const Duration(seconds: 3),
            () => callContractorDataApi());
  }


  changeLangToEnglish(BuildContext context,String setLanguage){
    Navigator.pop(context);
    GetStorage().write("language", setLanguage);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Language Change Please Wait')),
    );
    language = GetStorage().read("language")??"";
    Get.toNamed(AppRoutes.dashboardScreen);
    update();
  }

  int partyId = 0;
  String partyName = "";
  String? version;

  double failedToShow = 0.0;
  double paidToShow = 0.0;
  double intransitToShow = 0.0;

  Future getVersionData() async {
    isLoading = true;
    http.get(Uri.parse("https://api.demofms.com/api/Version/VersionName")).then((result){

      final body = json.decode(result.body);

      if(body["statusCode"]!=200){}
      else{
        version = body["result"];
        // failedToShow = GetStorage().read("failedAmt");
        // paidToShow = GetStorage().read("paidAmt");
        // intransitToShow = GetStorage().read("intransitAmt");
        // update();
      }
      update();
    });
  }

  navigateToDashboardFromDrawer(){
    Get.toNamed(AppRoutes.dashboardScreen);
    update();
  }

  navigateToProfileFromDrawer(){
    Get.toNamed(AppRoutes.profileScreen);
    update();
  }

  navigateToDashboardFromPhotoUpload(){
    isEnterManuallySelected = false; enterManuallyController.clear();
    isScanQrSelected = false;
    Get.toNamed(AppRoutes.dashboardScreen);
    update();
  }

  navigateToDashboardFromTrackBill(){
    isEnterManuallySelected = false; enterManuallyController.clear();
    isScanQrSelected = false;
    Get.toNamed(AppRoutes.dashboardScreen);
    update();
  }
  navigateToEnterTrackBill(){
    isEnterManuallySelected = false;
    isScanQrSelected = false;
    enterManuallyController.clear();
    Get.toNamed(AppRoutes.enterDataFromTrackBill);
    update();
  }

  navigateToEnterPhoto(){
    isEnterManuallySelected = false;
    isScanQrSelected = false;
    enterManuallyController.clear();
    Get.toNamed(AppRoutes.enterDataScreenFromPhotoUpload);
    update();
  }

  void callContractorDataApi() async {
    try {
      Utils.dismissKeyboard();
      isLoading = true;
      ContractorModel? response = (await repository.getContractorList(username,token));

      if (response.statusCode==200) {
        contractorList.addAll(response.contractorDetailsList!);

        for (var element in contractorList) {
          amount += element.payableAmount!;
        }

        partyId = contractorList[0].partyID!;
        partyName = contractorList[0].partyName!;
        callPaymentDataApi(partyId);
        update();
      } else if(response.statusCode==401){
        isLoading = false;
        goToLogout();
        update();
      }
      else if(response.statusCode==404){
        isLoading = false;
        update();
      }
        else {
        isLoading = false;
        update();
        }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      if(error.toString().contains("Token is Expired")) {
        goToLogout();
      }
      update();
    }
  }

  double paidStr = 0.0;
  double pendingStr = 0.0;
  double failedStr = 0.0;
  double billedAmt = 0.0;
  double paidAmt = 0.0;
  double intransitAmt = 0.0;

  void callPaymentDataApi(int partyId) async {
    paymentList.clear();
    try {
      Utils.dismissKeyboard();
      PaymentCountDetails? response = (await repository.getPaymentList(partyId, token));

      if (response.statusCode==200) {
        paymentList.addAll(response.paymentCountDetailsList!);


        // for (var element in paymentList) {
        //   if(element.totalPaidAmount==""){
        //
        //   }
        //   else{
        //     paidStr = double.parse(element.totalPaidAmount.toString().replaceAll(",", ""));
        //     update();
        //   }
        //
        //   if(element.totalPendingAmount == ""){}
        //   else {
        //     pendingStr = double.parse(element.totalPendingAmount.toString().replaceAll(",", ""));
        //     update();
        //   }
        //
        //   if(element.totalFailedAmount == ""){}
        //   else {
        //     failedStr = double.parse(element.totalFailedAmount.toString().replaceAll(",", ""));
        //     update();
        //   }
        //
        //   double failedBillAmount = failedStr;
        //   double paidBillAmount = paidStr;
        //   double pendingBillAmount = pendingStr;
        //
        //   billedAmt += failedBillAmount;
        //   paidAmt += paidBillAmount;
        //   intransitAmt += pendingBillAmount;
        //
        //   print("Amt");
        //   print(billedAmt);
        //   print(paidAmt);
        //   print(intransitAmt);
        //   // GetStorage().write("failedAmt", billedAmt);
        //   // GetStorage().write("paidAmt", paidAmt);
        //   // GetStorage().write("intransitAmt", intransitAmt);
        //   // update();
        //   isLoading = false;
        //   update();
        // }

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    update();
  }

  int workIdFromWorkOrder = 0;
  String workOrderNumberToShow = "";
  navigateToBillDataFromWorkOrder(int workId,String workNo){
    isLoading=true;
    workIdFromWorkOrder = workId;
    workOrderNumberToShow = workNo;
    Get.toNamed(AppRoutes.billDetailsFromWorkOrder);
    callBillDetailsFromWorkOrderDataApi(workId);
    update();
  }

  navigateToBillDataFromPhotoUpload(int workId,String workNo){
    isLoading=true;
    workIdFromWorkOrder = workId;
    workOrderNumberToShow = workNo;
    Get.toNamed(AppRoutes.billDetailsFromPhotoUpload);
    callBillDetailsFromWorkOrderDataApi(workId);
    update();
  }

  void callBillDetailsFromWorkOrderDataApi(int workId) async {
    billDataFromWorkOrderList.clear();
    try {
      BillDataFromWorkOrderModel? response = (await repository.getBillDetailsFromWorkOrderList(partyId,workId ,token));

      if (response.statusCode==200) {
        billDataFromWorkOrderList.addAll(response.billDataFromWorkOrderDetails!);
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  navigateToTrackBillFromWorkOrder(int billId){
    isLoading=true;
    //Get.toNamed(AppRoutes.trackBillFromWorkOrder);
    //callTrackBillFromWorkOrderDataApi(billId);
    callBillDetailsFromTrackBill(billId);
    update();
  }

  navigateToBillFromTrackBill(int billId){
    isLoading=true;
    //callTrackBillFromWorkOrderDataApi(billId);
    callBillDetailsFromTrackBill(billId);
    update();
  }

  goToUploadPhotoScreen(int billId){
    selectedBillIdForUploadPhoto = billId;
    Get.toNamed(AppRoutes.beforeAfterPhotoUpload);
    getCurrentPosition();
    update();
  }

  int selectedBillIdForUploadPhoto = 0;

  navigateToUploadPhotoFromPhotoUpload(int billId){
    isLoading=true;
    selectedBillIdForUploadPhoto = billId;
    Get.toNamed(AppRoutes.billDetailsFromPhotoUpload);
    update();
  }

  void callTrackBillFromWorkOrderDataApi(int billId) async {
    trackBillFromWorkOrderList.clear();
    try {
      TrackBillFromWorkOrderModel? response = (await repository.getTrackBillFromWorkOrderList(billId ,token));

      if (response.statusCode==200) {
        trackBillFromWorkOrderList.addAll(response.trackBillFromWorkOrderDetails!);
        enterManuallyController.clear(); isScanQrSelected = false;
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  void callBillDetailsFromTrackBill(int billId) async {
    trackBillDetailsList.clear();
    try {
      BillDetailsFromTrackBillModel? response = (await repository.getBillDetailsFromTrackBill(billId ,token));

      if (response.statusCode==200) {
        trackBillDetailsList.addAll(response.billDetailsListFromTrackBill!);
        enterManuallyController.clear();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    Get.toNamed(AppRoutes.trackBillList);
    update();
  }

  // navigateToPaymentLongData(String apiName){
  //   isLoading = true;
  //   Get.toNamed(AppRoutes.paymentLongDataScreen);
  //   //callPaymentLongDataApi();
  //
  //   if(apiName == "billed"){
  //     callPaymentBilledApi(); update();
  //   }
  //   else if(apiName == "paid"){
  //     callPaymentPaidApi();
  //   }
  //   else if(apiName == "intransit"){
  //     callPaymentIntransitApi();
  //   }
  //   update();
  // }

  // void callPaymentLongDataApi() async {
  //   paymentLongList.clear();
  //   try {
  //     PaymentLongListModel? response = (await repository.getPaymentLongList(partyId ,token));
  //
  //     if (response.statusCode==200) {
  //       paymentLongList.addAll(response.paymentLongListDetails!);
  //       isLoading = false;
  //       update();
  //     } else {
  //       isLoading = false;
  //       update();
  //     }
  //   } on CustomException catch (e) {
  //     isLoading = false;
  //     update();
  //   } catch (error) {
  //     isLoading = false;
  //     update();
  //   }
  // }
  List<PaymentDetailsList> paymentTypeList = [];
  void callPaymentBilledApi() async {
    paymentTypeList.clear();
    isLoading = true;
    Get.toNamed(AppRoutes.paymentLongDataScreen);
    try {
      PaymentDetailsModel? response = (await repository.getBilledList(partyId ,token));
      if (response.statusCode==200) {
        paymentTypeList.addAll(response.paymentDetailsList!);
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    update();
  }
  void callPaymentPaidApi() async {
    paymentTypeList.clear();
    isLoading = true;
    Get.toNamed(AppRoutes.paymentLongDataScreen);
    try {
      PaymentDetailsModel? response = (await repository.getPaidList(partyId ,token));

      if (response.statusCode==200) {
        paymentTypeList.addAll(response.paymentDetailsList!);
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    update();
  }
  void callPaymentIntransitApi() async {
    paymentTypeList.clear();
    isLoading = true;
    Get.toNamed(AppRoutes.paymentLongDataScreen);

    try {
      PaymentDetailsModel? response = (await repository.getIntransitList(partyId ,token));
      if (response.statusCode==200) {
        paymentTypeList.addAll(response.paymentDetailsList!);
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    update();
  }

  bool isEnterManuallySelected = false;
  bool isScanQrSelected = false;
  QRViewController? controller;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scanBarcode = '';
  TextEditingController enterManuallyController = TextEditingController();

  setVariable(){
    isScanQrSelected = true;
    isEnterManuallySelected = false;
    update();
  }

  setVariableForManually(){
    isScanQrSelected = false;
    isEnterManuallySelected = true;
    update();
  }

  setVariableForManuallyFromPhotoUpload(){
    isScanQrSelected = false;
    isEnterManuallySelected = true;
    update();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
  buildQr(BuildContext context){
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 200.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData.code == "" || scanData.code == null){

      }
      else{
        controller.pauseCamera();
        controller.stopCamera();
        result = scanData;
        scanBarcode = result!.code!;
        navigateToTrackBillFromWorkOrder(int.parse(result!.code!));
      }

      update();
    });
  }

  buildQrForPhotoUpload(BuildContext context){
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 200.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreatedForPhotoUpload,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void onQRViewCreatedForPhotoUpload(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData.code == "" || scanData.code == null){

      }
      else{
        controller.pauseCamera();
        controller.stopCamera();
        result = scanData;
        scanBarcode = result!.code!;
        callSearchWorkOrderDataApi(int.parse(result!.code!));
      }

      update();
    });
  }

  void callSearchWorkOrderDataApi(int workId) async {
    searchWorkOrderList.clear();
    try {
      WorkOrderSearchModel? response = (await repository.getSearchWorkOrderList(workId ,token));

      if (response.ok==200) {
        searchWorkOrderList.addAll(response.workOrderSearchDetails!);
        isLoading = false;
        enterManuallyController.clear();
        Get.toNamed(AppRoutes.searchWorkOrderList);
        update();
      } else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  //int? selectedPhotoBillId;


  int billIdSendToUploadPhotoApi = 0;

  navigateToUploadedPhotos(int billId,String workOrderNo){
    workOrderNumberToShow = workOrderNo;
    //selectedPhotoBillId = billId;
    billIdSendToUploadPhotoApi = billId;
    Get.toNamed(AppRoutes.uploadedPhotoScreen);
    //callPhotoUploadedDataApi(billId);
    update();
  }

  List<String> createDate = [];
  List<PhotoUploadedModel> demoPhotoModel = [];

  List<GetViewPhotoModel> uploadedPhotoList = [];
  List<ImageList> imgList = [];
  Uint8List? img;

  void callPhotoUploadedDataApi(int billId,String mode) async {
    photoUploadedList.clear();
    uploadedPhotoList.clear();
    isLoading = true;
    try {
      // PhotoUploadedModel? response = await repository.getPhotoUploadedList(billId ,token);
      //
      // //var jsonBody = json.decode(response.);
      //
      // print("api response");
      // print(response);
      // createDate.add(response.createdDate!);
      // //photoUploadedList.addAll(response.photoUploadedDetailsList!);
      //
      // print("Total");
      // print(createDate.length);
      // print(photoUploadedList.length);
      // isLoading = false;
      // update();

      var request = http.Request(
        'GET',
        Uri.parse("https://api.demofms.com/api/UploadedPhoto/GetUploadedPhoto"),
      )..headers.addAll({
        "Authorization": 'Bearer $token',
        HttpHeaders.contentTypeHeader: "application/json",
      });
      var params = {
        "BillID": billId, "Mode":mode
      };

      request.body = jsonEncode(params);
      http.StreamedResponse response = await request.send();
      final responsebody = await response.stream.bytesToString();

      if(response.statusCode == 200) {
        var jsonBody = json.decode(responsebody);

        // for(int i =0;i<5;i++){
        //   imgList.add(ImageList(
        //     id: i,
        //     imageName: "abc",
        //     imagePath: "path",
        //     mode: "mode",
        //     longitude: "longitude",
        //     latitude: "latitude",
        //     location: "location",
        //     //createdDate: data["createdDate"],
        //     //img: img,
        //   ));
        // }


        for (var data in jsonBody["result"]) {
          uploadedPhotoList.add(GetViewPhotoModel(
              createdDate: data["createdDate"]
          ));

          for(int i =0;i< data["imageList"].length; i++){

            var request = http.Request(
              'GET',
              Uri.parse("https://api.demofms.com/api/UploadedPhoto/GetUploadedImages"),
            )..headers.addAll({
              "Authorization": 'Bearer $token',
              HttpHeaders.contentTypeHeader: "application/json",
            });
            var params = {
              "ID": data["imageList"][i]["id"],
            };

            request.body = jsonEncode(params);
            http.StreamedResponse response = await request.send();
            var res = await http.Response.fromStream(response);

            if(res.statusCode == 200 ) {
              img = res.bodyBytes;
            }
            else {
              img = null;
            }

            imgList.add(ImageList(
              id: data["imageList"][i]["id"],
              imageName: data["imageList"][i]["imageName"],
              imagePath: data["imageList"][i]["imagePath"],
              mode: data["imageList"][i]["mode"],
              longitude: data["imageList"][i]["longitude"],
              latitude: data["imageList"][i]["latitude"],
              location: data["imageList"][i]["location"],
              createdDate: data["createdDate"],
              img: img,
            ));
          }
        }


        isLoading = false;
        update();
      }

      isLoading = false;
      update();

    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  List<TestUploadPhotoResult> testUploadedPhotoResult = [];

  navigateFromPhotoUploadedList(){
    radioValueOnPhotoList = -1;
    Get.toNamed(AppRoutes.searchWorkOrderList);
    update();
  }
  void testCallPhotoUploadedDataApi(int billId,String mode) async {
    testUploadedPhotoResult.clear();
    testViewPhotoList.clear();
    isLoading = true;
    try {
      TestUploadPhotoModel? response = await repository.getPhotoUploadedList(billId ,token,mode);

      testUploadedPhotoResult.addAll(response.testUploadPhotoResult!);

      for (var element1 in response.testUploadPhotoResult!) {
        for (var element2 in element1.testImageList!) {


          // TestViewPhotoModel? response = await repository.getPhotoUploadedView(element.id! ,token);
          // testViewPhotoList.add(response);

          testCallUploadPhotoView(element2.id!);

          //element.viewImage =  response.uint8listPhoto;

          // for(int i =0; i<testUploadedPhotoResult.length; i++){
          //   for(int j =0; j<testUploadedPhotoResult[i].testImageList!.length; j++){
          //     testUploadedPhotoResult[i].testImageList![j].viewImage = response.uint8listPhoto;
          //     print(response.photoId);
          //
          //     testUploadedPhotoResult[i].testImageList!.insert(j, TestImageList(
          //       viewImage: response.uint8listPhoto,
          //     ));
          //
          //     // testUploadedPhotoResult[i].testImageList!.add(
          //     //     TestImageList(
          //     //
          //     //     );
          //     // );
          //   }
          // }

          //testCallUploadPhotoView(element.id!);

          // var request = http.Request(
          //   'GET',
          //   Uri.parse("https://api.demofms.com/api/UploadedPhoto/GetUploadedImages"),
          // )..headers.addAll({
          //   "Authorization": 'Bearer $token',
          //   HttpHeaders.contentTypeHeader: "application/json",
          // });
          // var params = {
          //   "ID": data["imageList"][i]["id"],
          // };
          //
          // request.body = jsonEncode(params);
          // http.StreamedResponse response = await request.send();
          // var res = await http.Response.fromStream(response);
          //
          // if(res.statusCode == 200 ) {
          //   img = res.bodyBytes;
          // }
          // else {
          //   img = null;
          // }

        }
      }

      isLoading = false;
      update();

     isLoading = false;
      update();

    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  List<TestViewPhotoModel> testViewPhotoList = [];

  testCallUploadPhotoView(int id) async{
    try{
      TestViewPhotoModel? response = await repository.getPhotoUploadedView(id ,token);
      testViewPhotoList.add(response);



      // testUploadedPhotoResult.forEach((element1) {
      //   element1.testImageList!.forEach((element2) {
      //     testUploadedPhotoResult[element1.].testImageList[element2].viewImage = response;
      //   });
      // });
      // }

      for(int i =0; i<testUploadedPhotoResult.length; i++){
        for(int j =0; j<testUploadedPhotoResult[i].testImageList!.length; j++){
          testUploadedPhotoResult[i].testImageList![j].viewImage = response.uint8listPhoto;

        }
      }



      isLoading = false;
      update();

    }on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  String? currentAddress;
  Position? currentPosition;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showErrorSnackBar("Location services are disabled. Please enable the services");
      update();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      Utils.showErrorSnackBar("Location permissions are denied");
      update();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.showErrorSnackBar("Location permissions are permanently denied, we cannot request permissions.");
      update();
      return false;
    }
    update();
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    update();
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, '
          '${place.subAdministrativeArea}, ${place.postalCode}';

      update();
    }).catchError((e) {
      debugPrint(e);
    });
    update();
  }

  String? gender;
  int radioValue = -1;
  int radioValueOnPhotoList = -1;

  handleRadioValueChanged(int value) {
    radioValue = value;
    update();
  }

  radioChangeAndCallApi(int value,String mode) {
    radioValueOnPhotoList = value;
    //testCallPhotoUploadedDataApi(billIdSendToUploadPhotoApi,mode);
    uploadedPhotoList.clear();imgList.clear();
    callPhotoUploadedDataApi(billIdSendToUploadPhotoApi,mode);
    update();
  }

  File? imageFile;
  final picker = ImagePicker();
  bool isSelected = false;

  pickImageFromCamera() async {
    try{
      final pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
      imageFile = pickedImage != null ? File(pickedImage.path) : null;
      if (imageFile != null) {
        imageFile = imageFile;
        isSelected = true;
        update();
      }
    }
    catch (error) {
      isSelected = false;update();
    }
  }

  int statusCode = 200;

  validateUploadPhoto(){
    isLoading = true;
    if(imageFile==null){
      Utils.showErrorSnackBar('Please add photo');isLoading = false;update();
    }
    else if(radioValue==-1){
      Utils.showErrorSnackBar('Please select before or after');isLoading = false;update();
    }
    else{
      //callPhotoUpload(selectedBillIdForUploadPhoto.toString());
      callPhotoSet(selectedBillIdForUploadPhoto.toString());
    }

    update();
  }

  Future callPhotoUpload(String billId) async {
    Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://api.demofms.com/api/UploadedPhoto/SetUploadedPhotoDetails'),
    );
    request.headers.addAll(headers);
    request.fields['BillID'] = billId;
    request.fields['Longitude'] = currentPosition!.longitude.toString();
    request.fields['Latitude'] = currentPosition!.latitude.toString();
    request.fields['Location'] = currentAddress.toString();

    request.files.add(await http.MultipartFile.fromPath('Image', imageFile!.path));

    var res = await request.send();
    statusCode = res.statusCode;

    final responsebody = await res.stream.bytesToString();
    Map jsonBody = json.decode(responsebody);


    if(jsonBody["status"]==200){
      Utils.showSuccessSnackBar(jsonBody["result"]);
      imageFile=null;isSelected=false;isLoading=false;
      update();
    }
    else if(jsonBody["status"]==403){
      Utils.showErrorSnackBar("Something went wrong.Please try again later!");
      imageFile=null;isSelected=false;isLoading=false;
      update();
    }
    else{
      Utils.showErrorSnackBar('Something went wrong');
      isLoading=false;
    }

    imageFile=null;isSelected=false;isLoading=false;
    update();

    return res.reasonPhrase;
  }

  void callPhotoSet(String billId) async {
    isLoading = true;
    try {
      var response = (await repository.getAddPhoto(
        billId: billId,
        lat: currentPosition!.latitude.toString(),
        long: currentPosition!.longitude.toString(),
        loc: currentAddress.toString(),
        image: imageFile!.path==""?"": imageFile!.path,
        deviceToken : token,
        mode: radioValue == 0 ? "Before":"After"
      ));

      response.listen((value) {
        Map jsonBody = json.decode(value);

        if(jsonBody["status"]==200){
          Utils.showSuccessSnackBar(jsonBody["result"]); isLoading=false;
        }
        else{
          Utils.showSuccessSnackBar(jsonBody["result"]); isLoading=false;
        }

        imageFile=null;isSelected=false;isLoading=false;
        update();
      });

      isLoading = false;

      update();
    } on CustomException {
      //Utils.showErrorSnackBar(responseDecode['Message']);
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      //Utils.showErrorSnackBar(responseDecode['Message']);
      update();
    }
  }

  navigateToBillFromPhotoUpload(){
    imageFile=null;isSelected=false;isLoading=false;
    Get.toNamed(AppRoutes.billDetailsFromPhotoUpload);
    update();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Uint8List? viewSelectedImage;

  navigateToViewImage(Uint8List image){
    viewSelectedImage = image;
    Get.toNamed(AppRoutes.viewPhotoScreen);
    update();
  }

  goToLogout() {
    GetStorage().remove("username");
    GetStorage().remove("token");
    GetStorage().remove("language");
    GetStorage().write("isLogin", false);
    GetStorage().erase();
    update();
    Get.offAllNamed(AppRoutes.login);
    update();
  }
}