class CustomResponse {
  bool? status;
  String? message;

  CustomResponse({this.status, this.message});

  CustomResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
class ApiResponse {
  bool? success;
  String? message;

  ApiResponse({this.success, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success']??"";
    message = json['Message']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    return data;
  }
}
class CheckTimesheetApiResponse {
  bool? success;
  String? message;
  String? flag;

  CheckTimesheetApiResponse({this.success, this.message});

  CheckTimesheetApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success']??"";
    message = json['Message']??"";
    flag = json['Flag']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['Flag'] = flag;
    return data;
  }
}
class CheckTimesheetTimeResponse {
  bool? success;
  String? message;
  String? totalTime;
  String? balanceTime;

  CheckTimesheetTimeResponse({this.success, this.message});

  CheckTimesheetTimeResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success']??"";
    message = json['Message']??"";
    totalTime = json['total_time']??"";
    balanceTime = json['balance_time']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['total_time'] = totalTime;
    data['balance_time'] = balanceTime;
    return data;
  }
}
class TotalLeaveCountResponse {
  bool? success;
  String? message;
  String? totalLeaves;

  TotalLeaveCountResponse({this.success, this.message, this.totalLeaves});

  TotalLeaveCountResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success']??"";
    message = json['Message']??"";
    totalLeaves = json['Total leaves']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['Total leaves'] = totalLeaves;
    return data;
  }
}
class LoginResponse {
  int? statusCode;
  String? result;

  LoginResponse({this.statusCode,this.result });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['result'] = result;
    return data;
  }
}

class AccessRightResponse {
  String? message;
  bool? success;
  List<AccessRightDetails>? accessRightDetails;

  AccessRightResponse({this.message, this.success, this.accessRightDetails});

  AccessRightResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      accessRightDetails = <AccessRightDetails>[];
      json['data'].forEach((v) {
        accessRightDetails!.add(AccessRightDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (accessRightDetails != null) {
      data['data'] = accessRightDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccessRightDetails {
  String? moduleName;
  String? addAccess;

  AccessRightDetails({this.moduleName, this.addAccess});

  AccessRightDetails.fromJson(Map<String, dynamic> json) {
    moduleName = json['module_name'];
    addAccess = json['add_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module_name'] = moduleName;
    data['add_access'] = addAccess;
    return data;
  }
}


