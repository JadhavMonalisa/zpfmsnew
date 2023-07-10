class BillDetailsFromTrackBillModel {
  int? statusCode;
  List<BillDetailsListFromTrackBill>? billDetailsListFromTrackBill;

  BillDetailsFromTrackBillModel({this.statusCode, this.billDetailsListFromTrackBill});

  BillDetailsFromTrackBillModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      billDetailsListFromTrackBill = <BillDetailsListFromTrackBill>[];
      json['result'].forEach((v) {
        billDetailsListFromTrackBill!.add(BillDetailsListFromTrackBill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (billDetailsListFromTrackBill != null) {
      data['result'] = billDetailsListFromTrackBill!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillDetailsListFromTrackBill {
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
  String? utrDate;
  String? partyName;

  BillDetailsListFromTrackBill(
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
        this.utrno,
        this.utrDate,
        this.partyName});

  BillDetailsListFromTrackBill.fromJson(Map<String, dynamic> json) {
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
    utrDate = json['utrDate'];
    partyName = json['partyName'];
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
    data['utrDate'] = utrDate;
    data['partyName'] = partyName;
    return data;
  }
}