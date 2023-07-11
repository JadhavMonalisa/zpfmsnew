
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:zpfmsnew/constant/api_endpoint.dart';
import 'package:zpfmsnew/constant/provider/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:zpfmsnew/screens/dashboard/dashboard/dashboard_model.dart';
import 'package:zpfmsnew/screens/dashboard/payment/payment_model.dart';
import 'package:zpfmsnew/screens/dashboard/photo_upload/photo_upload_model.dart';
import 'package:zpfmsnew/screens/dashboard/track_bill/track_bill_model.dart';
import 'package:zpfmsnew/screens/dashboard/work_order/work_order_model.dart';
import 'package:zpfmsnew/utils/custom_response.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({required this.apiClient});

  String username = "";
  String language = "";
  String? token;

  Map<String, String> multipartHeaders = { "Content-Type": "multipart/form-data"};

  getData(){
    username = GetStorage().read("username")??"";
    language = GetStorage().read("language")??"";
    token = GetStorage().read("token")??"";
  }

  ///login api
  Future<LoginResponse> doLogin(String? username,String? password,String? deviceId) async {
    Map<String, String> headers = { "Content-Type": "application/json"};
    var params = {"Name":username,"Password":password,"DeviceID":deviceId};
    final response = await apiClient.post(
      ApiEndpoint.loginUrl,
      body: params, headers: headers,
    );
    return LoginResponse.fromJson(response);
  }

  Future<ContractorModel> getContractorList(String username,String token) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.contractorListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });
    var params = {"Mobile": username.toString(),};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();
    Map<String, dynamic> jsonBody = json.decode(responsebody);

    if(responsebody=="Token is Expired"){
      List<ContractorDetails> contractorDetailsList = [];
      return ContractorModel(
        statusCode: 401,
        contractorDetailsList: contractorDetailsList
      );
    }
    else{
      return ContractorModel.fromJson(jsonBody);
    }

  }

  Future<PaymentCountDetails> getPaymentList(int partyId,String token) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.billCountListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyId": partyId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();
    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return PaymentCountDetails.fromJson(jsonBody);
  }

  Future<BillDataFromWorkOrderModel> getBillDetailsFromWorkOrderList(int partyId,int workId,String token) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.billDetailsListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyId": partyId,"WorkID": workId };
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return BillDataFromWorkOrderModel.fromJson(jsonBody);
  }

  Future<TrackBillFromWorkOrderModel> getTrackBillFromWorkOrderList(int billId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.billDetailsByBillIdListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"BillID": billId,};
    request.body = jsonEncode(params);

    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return TrackBillFromWorkOrderModel.fromJson(jsonBody);
  }

  Future<BillDetailsFromTrackBillModel> getBillDetailsFromTrackBill(int billId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.billDetailsByBillIdListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });


    var params = {"BillID": billId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return BillDetailsFromTrackBillModel.fromJson(jsonBody);
  }

  Future<PaymentLongListModel> getPaymentLongList(int partyId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.billDetailsByPartyIdListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyID": partyId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return PaymentLongListModel.fromJson(jsonBody);
  }
  Future<BillDataFromWorkOrderModel> getBillListFromEnter(int partyId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.billDetailsByPartyIdListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyID": partyId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return BillDataFromWorkOrderModel.fromJson(jsonBody);
  }
  Future<PaymentDetailsModel> getBilledList(int partyId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.getBilledListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyID": partyId,};
    request.body = jsonEncode(params);
    print("params");
    print(params);
    print(token);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return PaymentDetailsModel.fromJson(jsonBody);
  }
  Future<PaymentDetailsModel> getPaidList(int partyId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.getPaidListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyID": partyId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return PaymentDetailsModel.fromJson(jsonBody);
  }
  Future<PaymentDetailsModel> getIntransitList(int partyId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.getIntransitListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PartyID": partyId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return PaymentDetailsModel.fromJson(jsonBody);
  }

  Future<WorkOrderSearchModel> getSearchWorkOrderList(int workId,String token) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.searchWorkOrderListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"WorkID": workId,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return WorkOrderSearchModel.fromJson(jsonBody);
  }

  Future<Stream<String>> getAddPhoto({String? billId,String? lat,String? long,String? loc,
   String? image,String? deviceToken,String? mode}) async {

    Map<String, String> multipartHeadersForPhoto = {
      "Content-Type": "multipart/form-data",
      "Authorization": 'Bearer $deviceToken',
    };

    var uri = Uri.parse(ApiEndpoint.setUploadedPhotoUrl);
    var request =  http.MultipartRequest("POST", uri);
    //request.headers.addAll(multipartHeaders);
    request.headers.addAll(multipartHeadersForPhoto);

    request.fields['BillID'] = billId!;
    request.fields['Longitude'] = long!;
    request.fields['Latitude'] = lat!;
    request.fields['Location'] = loc!;
    request.fields['Mode'] = mode!;

    var length = await File(image!).length();
    var stream =  http.ByteStream(Stream.castFrom(File(image).openRead()));
    var multipartFileSign =  http.MultipartFile('Image', stream,length, filename: basename(File(image).path));
    request.files.add(multipartFileSign);
    var response = await request.send();

    return response.stream.transform(utf8.decoder);
  }

  Future<TestUploadPhotoModel> getPhotoUploadedList(int billId,String token,String mode) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.uploadedPhotoListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"BillID": billId,"Mode":mode};
    request.body = jsonEncode(params);

    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return TestUploadPhotoModel.fromJson(jsonBody);
  }

  Future<TestViewPhotoModel> getPhotoUploadedView(int photoId,String token) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.uploadedPhotoViewUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"ID": photoId};

    request.body = jsonEncode(params);

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    //
    // print(res.statusCode);
    // print(res.body);
    // print(res.bodyBytes);
    return TestViewPhotoModel(res.bodyBytes,photoId);
  }

  Future<LoginResponse> getMobileNoVerifyForRegistration(String mobNo) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.verifyMobNoForRegistrationUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"MobileNo": mobNo,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    print("responsebody");
    print(responsebody);
    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getMobileNoVerifyForForgotPassword(String mobNo) async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiEndpoint.verifyMobNoForForgotPassUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"MobileNo": mobNo,};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getOtpVerifyForForgotPassword(String mobNo,String otp) async {
    var request = http.Request(
      'POST',
      Uri.parse(ApiEndpoint.verifyOtpForForgotPassUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {'MobileNo': mobNo,"OTP":otp};

    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getOtpVerifyForRegistration(String mobNo,String otp) async {
    var request = http.Request(
      'POST',
      Uri.parse(ApiEndpoint.verifyOtpForRegistrationUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {'MobileNo': mobNo,"MobileOTP":otp};

    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getSetPasswordForForgotPassword(String mobNo,String pass) async {
    var request = http.Request(
      'POST',
      Uri.parse(ApiEndpoint.setPassForForgotPassUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {
      'MobileNo': mobNo,
      'Password': pass};

    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getSetPasswordForRegistration(String mobNo,String pass) async {
    var request = http.Request(
      'POST',
      Uri.parse(ApiEndpoint.setPassForRegistrationUrl),
    )..headers.addAll({
      //"Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {
      'MobileNo': mobNo,
      'Password': pass};

    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
  Future<LoginResponse> getResendPasswordForForgotPassword(String mobNo) async {
    var request = http.Request(
      'POST',
      Uri.parse(ApiEndpoint.resendOtpForForgotPassUrl),
    )..headers.addAll({
     // "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {'MobileNo': mobNo,};

    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LoginResponse.fromJson(jsonBody);
  }
}