class ApiEndpoint {
  ///Registration
  static const String verifyMobNoForRegistrationUrl = "https://api.demofms.com/api/Contractor/CheckMobileNumber";
  static const String verifyOtpForRegistrationUrl = "https://api.demofms.com/api/OTP/VerifyOTP";
  static const String setPassForRegistrationUrl = "https://api.demofms.com/api/OTP/SetPassword";
  ///Login
  static const String loginUrl = "https://api.demofms.com/api/Users/authenticate";
  ///Forgot password
  static const String verifyMobNoForForgotPassUrl = "https://api.demofms.com/api/Users/ForgetPassword";
  static const String verifyOtpForForgotPassUrl = "https://api.demofms.com/api/Users/VerifyForgetPasswordOTP";
  static const String setPassForForgotPassUrl = "https://api.demofms.com/api/Users/SetForgetPassword";
  static const String resendOtpForForgotPassUrl = "https://api.demofms.com/api/OTP/SendOTP";
  ///Dashboard
  static const String contractorListUrl = "https://api.demofms.com/api/Contractor/GetContractorDetails";
  static const String billCountListUrl = "https://api.demofms.com/api/BillCount/GetBillCountDetails";
  ///Work order
  static const String billDetailsListUrl = "https://api.demofms.com/api/BillDetails/GetBillDetails";
  static const String billDetailsByBillIdListUrl = "https://api.demofms.com/api/BillDetails/GetBillDetailsbyBillID";
  ///payment
  static const String billDetailsByPartyIdListUrl = "https://api.demofms.com/api/BillDetails/GetBillDetailsByPartyID";
  static const String getBilledListUrl = "https://api.demofms.com/api/BillDetails/GetBilledDetailsByPartyID";
  static const String getPaidListUrl = "https://api.demofms.com/api/BillDetails/GetPaidBillDetailsByPartyID";
  static const String getIntransitListUrl = "https://api.demofms.com/api/BillDetails/GetIntransitBillDetailsByPartyID";
  ///Photo upload
  static const String searchWorkOrderListUrl = "https://api.demofms.com/api/work/GetWorkOrderDetailsByWorkID";
  static const String setUploadedPhotoUrl = "https://api.demofms.com/api/UploadedPhoto/SetUploadedPhotoDetails";
  static const String uploadedPhotoListUrl = "https://api.demofms.com/api/UploadedPhoto/GetUploadedPhoto";
  static const String uploadedPhotoViewUrl = "https://api.demofms.com/api/UploadedPhoto/GetUploadedImages";

}