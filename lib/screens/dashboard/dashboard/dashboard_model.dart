class ContractorModel {
  int? statusCode;
  List<ContractorDetails>? contractorDetailsList;

  ContractorModel({this.statusCode, this.contractorDetailsList});

  ContractorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      contractorDetailsList = <ContractorDetails>[];
      json['result'].forEach((v) {
        contractorDetailsList!.add(ContractorDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (contractorDetailsList != null) {
      data['result'] = contractorDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContractorDetails {
  String? mobile;
  int? partyID;
  String? partyName;
  String? financialYear;
  String? districtName;
  String? workName;
  String? workOrderNo;
  String? workOrderDate;
  int? payableAmount;
  int? distID;
  int? billID;
  int? workDetailsID;
  String? bankName;
  String? micrCode;
  String? ifsCCode;
  String? bankAccountNumber;
  int? userRole;

  ContractorDetails(
      {this.mobile,
        this.partyID,
        this.partyName,
        this.financialYear,
        this.districtName,
        this.workName,
        this.workOrderNo,
        this.workOrderDate,
        this.payableAmount,
        this.distID,
        this.billID,
        this.workDetailsID,
        this.bankName,
        this.micrCode,
        this.ifsCCode,
        this.bankAccountNumber,
        this.userRole});

  ContractorDetails.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile']??"";
    partyID = json['partyID']??"";
    partyName = json['partyName']??"";
    financialYear = json['financialYear']??"";
    districtName = json['districtName']??"";
    workName = json['workName']??"";
    workOrderNo = json['workOrderNo']??"";
    workOrderDate = json['workOrderDate']??"";
    payableAmount = json['payableAmount']??"";
    distID = json['distID']??"";
    billID = json['billID']??"";
    workDetailsID = json['workDetailsID']??"";
    bankName = json['bankName']??"";
    micrCode = json['micrCode']??"";
    ifsCCode = json['ifsC_Code']??"";
    bankAccountNumber = json['bank_AccountNumber']??"";
    userRole = json['userRole']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['partyID'] = partyID;
    data['partyName'] = partyName;
    data['financialYear'] = financialYear;
    data['districtName'] = districtName;
    data['workName'] = workName;
    data['workOrderNo'] = workOrderNo;
    data['workOrderDate'] = workOrderDate;
    data['payableAmount'] = payableAmount;
    data['distID'] = distID;
    data['billID'] = billID;
    data['workDetailsID'] = workDetailsID;
    data['bankName'] = bankName;
    data['micrCode'] = micrCode;
    data['ifsC_Code'] = ifsCCode;
    data['bank_AccountNumber'] = bankAccountNumber;
    data['userRole'] = userRole;
    return data;
  }
}

class PaymentCountDetails {
  int? statusCode;
  List<PaymentCountList>? paymentCountDetailsList;

  PaymentCountDetails({this.statusCode, this.paymentCountDetailsList});

  PaymentCountDetails.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      paymentCountDetailsList = <PaymentCountList>[];
      json['result'].forEach((v) {
        paymentCountDetailsList!.add(PaymentCountList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (paymentCountDetailsList != null) {
      data['result'] = paymentCountDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentCountList {
  int? paidBillCount;
  int? pendingBillCount;
  int? billedBillCount;
  String? totalPaidAmount;
  String? totalPendingAmount;
  String? totalBilledAmount;
  int? billID;

  PaymentCountList(
      {this.paidBillCount,
        this.pendingBillCount,
        this.billedBillCount,
        this.totalPaidAmount,
        this.totalPendingAmount,
        this.totalBilledAmount,
        this.billID});

  PaymentCountList.fromJson(Map<String, dynamic> json) {
    paidBillCount = json['paidBillCount']??"";
    pendingBillCount = json['pendingBillCount']??"";
    billedBillCount = json['billedCount']??"";
    totalPaidAmount = json['totalPaidAmount']??"";
    totalPendingAmount = json['totalPendingAmount']??"";
    totalBilledAmount = json['billedAmount']==""?"0": json['billedAmount']??"";
    billID = json['billID']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paidBillCount'] = paidBillCount;
    data['pendingBillCount'] = pendingBillCount;
    data['failedBillCount'] = billedBillCount;
    data['totalPaidAmount'] = totalPaidAmount;
    data['totalPendingAmount'] = totalPendingAmount;
    data['totalFailedAmount'] = totalBilledAmount;
    data['billID'] = billID;
    return data;
  }
}