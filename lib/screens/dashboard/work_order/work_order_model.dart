class BillDataFromWorkOrderModel {
  int? statusCode;
  List<BillDataFromWorkOrderDetails>? billDataFromWorkOrderDetails;

  BillDataFromWorkOrderModel({this.statusCode, this.billDataFromWorkOrderDetails});

  BillDataFromWorkOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      billDataFromWorkOrderDetails = <BillDataFromWorkOrderDetails>[];
      json['result'].forEach((v) {
        billDataFromWorkOrderDetails!.add(BillDataFromWorkOrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (billDataFromWorkOrderDetails != null) {
      data['result'] = billDataFromWorkOrderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillDataFromWorkOrderDetails {
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

  BillDataFromWorkOrderDetails(
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
        this.utrno
      });

  BillDataFromWorkOrderDetails.fromJson(Map<String, dynamic> json) {
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

class TrackBillFromWorkOrderModel {
  int? statusCode;
  List<TrackBillFromWorkOrderDetails>? trackBillFromWorkOrderDetails;

  TrackBillFromWorkOrderModel({this.statusCode, this.trackBillFromWorkOrderDetails});

  TrackBillFromWorkOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      trackBillFromWorkOrderDetails = <TrackBillFromWorkOrderDetails>[];
      json['result'].forEach((v) {
        trackBillFromWorkOrderDetails!.add(TrackBillFromWorkOrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (trackBillFromWorkOrderDetails != null) {
      data['result'] = trackBillFromWorkOrderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrackBillFromWorkOrderDetails {
  String? billDate;
  int? billID;
  int? billAmount;
  String? partyName;
  String? utrno;
  String? utrDate;
  String? districtName;

  TrackBillFromWorkOrderDetails(
      {this.billDate,
        this.billID,
        this.billAmount,
        this.partyName,
        this.utrno,
        this.utrDate,
        this.districtName});

  TrackBillFromWorkOrderDetails.fromJson(Map<String, dynamic> json) {
    billDate = json['billDate'];
    billID = json['billID'];
    billAmount = json['billAmount'];
    partyName = json['partyName'];
    utrno = json['utrno'];
    utrDate = json['utrDate'];
    districtName = json['districtName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billDate'] = billDate;
    data['billID'] = billID;
    data['billAmount'] = billAmount;
    data['partyName'] = partyName;
    data['utrno'] = utrno;
    data['utrDate'] = utrDate;
    data['districtName'] = districtName;
    return data;
  }
}