class PaymentLongListModel {
  int? statusCode;
  List<PaymentLongListDetails>? paymentLongListDetails;

  PaymentLongListModel({this.statusCode, this.paymentLongListDetails});

  PaymentLongListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      paymentLongListDetails = <PaymentLongListDetails>[];
      json['result'].forEach((v) {
        paymentLongListDetails!.add(PaymentLongListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (paymentLongListDetails != null) {
      data['result'] = paymentLongListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentLongListDetails {
  String? districtName;
  String? workOrderNo;
  String? workName;
  String? billID;
  String? demandNo;
  String? billAmount;
  String? cashBookNameMarathi;
  String? headNameMarathi;
  String? approvalStatus;
  int? deductionAmount;
  int? netAmount;
  String? paymentStatus;
  String? billDate;
  int? workID;

  PaymentLongListDetails(
      {this.districtName,
        this.workOrderNo,
        this.workName,
        this.billID,
        this.demandNo,
        this.billAmount,
        this.cashBookNameMarathi,
        this.headNameMarathi,
        this.approvalStatus,
        this.deductionAmount,
        this.netAmount,
        this.paymentStatus,
        this.billDate,
        this.workID});

  PaymentLongListDetails.fromJson(Map<String, dynamic> json) {
    districtName = json['districtName'];
    workOrderNo = json['workOrderNo'];
    workName = json['workName'];
    billID = json['billID'];
    demandNo = json['demandNo'];
    billAmount = json['billAmount'];
    cashBookNameMarathi = json['cashBookNameMarathi'];
    headNameMarathi = json['headNameMarathi'];
    approvalStatus = json['approvalStatus'];
    deductionAmount = json['deductionAmount'];
    netAmount = json['netAmount'];
    paymentStatus = json['paymentStatus'];
    billDate = json['billDate'];
    workID = json['workID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['districtName'] = districtName;
    data['workOrderNo'] = workOrderNo;
    data['workName'] = workName;
    data['billID'] = billID;
    data['demandNo'] = demandNo;
    data['billAmount'] = billAmount;
    data['cashBookNameMarathi'] = cashBookNameMarathi;
    data['headNameMarathi'] = headNameMarathi;
    data['approvalStatus'] = approvalStatus;
    data['deductionAmount'] = deductionAmount;
    data['netAmount'] = netAmount;
    data['paymentStatus'] = paymentStatus;
    data['billDate'] = billDate;
    data['workID'] = workID;
    return data;
  }
}

class PaymentDetailsModel {
  int? statusCode;
  List<PaymentDetailsList>? paymentDetailsList;

  PaymentDetailsModel({this.statusCode, this.paymentDetailsList});

  PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      paymentDetailsList = <PaymentDetailsList>[];
      json['result'].forEach((v) {
        paymentDetailsList!.add(PaymentDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (paymentDetailsList != null) {
      data['result'] = paymentDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetailsList {
  String? districtName;
  String? workOrderNo;
  String? workName;
  String? billID;
  String? demandNo;
  String? billAmount;
  String? cashBookNameMarathi;
  String? headNameMarathi;
  String? approvalStatus;
  int? deductionAmount;
  int? netAmount;
  String? paymentStatus;
  String? billDate;
  int? workID;
  String? utrno;

  PaymentDetailsList(
      {this.districtName,
        this.workOrderNo,
        this.workName,
        this.billID,
        this.demandNo,
        this.billAmount,
        this.cashBookNameMarathi,
        this.headNameMarathi,
        this.approvalStatus,
        this.deductionAmount,
        this.netAmount,
        this.paymentStatus,
        this.billDate,
        this.workID,
        this.utrno});

  PaymentDetailsList.fromJson(Map<String, dynamic> json) {
    districtName = json['districtName'];
    workOrderNo = json['workOrderNo'];
    workName = json['workName'];
    billID = json['billID'];
    demandNo = json['demandNo'];
    billAmount = json['billAmount'];
    cashBookNameMarathi = json['cashBookNameMarathi'];
    headNameMarathi = json['headNameMarathi'];
    approvalStatus = json['approvalStatus'];
    deductionAmount = json['deductionAmount'];
    netAmount = json['netAmount'];
    paymentStatus = json['paymentStatus'];
    billDate = json['billDate'];
    workID = json['workID'];
    utrno = json['utrno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['districtName'] = districtName;
    data['workOrderNo'] = workOrderNo;
    data['workName'] = workName;
    data['billID'] = billID;
    data['demandNo'] = demandNo;
    data['billAmount'] = billAmount;
    data['cashBookNameMarathi'] = cashBookNameMarathi;
    data['headNameMarathi'] = headNameMarathi;
    data['approvalStatus'] = approvalStatus;
    data['deductionAmount'] = deductionAmount;
    data['netAmount'] = netAmount;
    data['paymentStatus'] = paymentStatus;
    data['billDate'] = billDate;
    data['workID'] = workID;
    data['utrno'] = utrno;
    return data;
  }
}