import 'dart:typed_data';

class WorkOrderSearchModel {
  int? ok;
  List<WorkOrderSearchDetails>? workOrderSearchDetails;

  WorkOrderSearchModel({this.ok, this.workOrderSearchDetails});

  WorkOrderSearchModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['result'] != null) {
      workOrderSearchDetails = <WorkOrderSearchDetails>[];
      json['result'].forEach((v) {
        workOrderSearchDetails!.add(WorkOrderSearchDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    if (workOrderSearchDetails != null) {
      data['result'] = workOrderSearchDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkOrderSearchDetails {
  int? srNo;
  int? workID;
  String? district;
  String? workOrderName;
  String? workOrderDate;
  int? workOrderAmount;
  int? billID;
  String? workOrderNo;

  WorkOrderSearchDetails(
      {this.srNo,
        this.workID,
        this.district,
        this.workOrderName,
        this.workOrderDate,
        this.workOrderAmount,
        this.billID,
        this.workOrderNo,
      });

  WorkOrderSearchDetails.fromJson(Map<String, dynamic> json) {
    srNo = json['srNo'];
    workID = json['workID'];
    district = json['district'];
    workOrderName = json['workOrderName'];
    workOrderDate = json['workOrderDate'];
    workOrderAmount = json['workOrderAmount'];
    billID = json['billID'];
    workOrderNo = json['workOrderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['srNo'] = srNo;
    data['workID'] = workID;
    data['district'] = district;
    data['workOrderName'] = workOrderName;
    data['workOrderDate'] = workOrderDate;
    data['workOrderAmount'] = workOrderAmount;
    data['billID'] = billID;
    data['workOrderNo'] = workOrderNo;
    return data;
  }
}

class PhotoUploadedModel {
  String? createdDate;
  List<PhotoUploadedDetailsList>? photoUploadedDetailsList;

  PhotoUploadedModel({this.createdDate, this.photoUploadedDetailsList});

  PhotoUploadedModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    if (json['imageList'] != null) {
      photoUploadedDetailsList = <PhotoUploadedDetailsList>[];
      json['imageList'].forEach((v) {
        photoUploadedDetailsList!.add(PhotoUploadedDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    if (photoUploadedDetailsList != null) {
      data['imageList'] = photoUploadedDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoUploadedDetailsList {
  int? id;
  String? imageName;
  String? imagePath;

  PhotoUploadedDetailsList({this.id, this.imageName, this.imagePath});

  PhotoUploadedDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageName'] = imageName;
    data['imagePath'] = imagePath;
    return data;
  }
}

class TestUploadPhotoModel {
  int? statusCode;
  List<TestUploadPhotoResult>? testUploadPhotoResult;

  TestUploadPhotoModel({this.statusCode, this.testUploadPhotoResult});

  TestUploadPhotoModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      testUploadPhotoResult = <TestUploadPhotoResult>[];
      json['result'].forEach((v) {
        testUploadPhotoResult!.add(TestUploadPhotoResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (testUploadPhotoResult != null) {
      data['result'] = testUploadPhotoResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestUploadPhotoResult {
  String? createdDate;
  List<TestImageList>? testImageList;

  TestUploadPhotoResult({this.createdDate, this.testImageList});

  TestUploadPhotoResult.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    if (json['imageList'] != null) {
      testImageList = <TestImageList>[];
      json['imageList'].forEach((v) {
        testImageList!.add(TestImageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    if (testImageList != null) {
      data['imageList'] = testImageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestImageList {
  int? id;
  String? imageName;
  String? imagePath;
  String? mode;
  String? longitude;
  String? latitude;
  String? location;
  Uint8List? viewImage;

  TestImageList(
      {this.id,
        this.imageName,
        this.imagePath,
        this.mode,
        this.longitude,
        this.latitude,
        this.location,
        this.viewImage});

  TestImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
    mode = json['mode'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageName'] = imageName;
    data['imagePath'] = imagePath;
    data['mode'] = mode;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['location'] = location;
    return data;
  }
}

class TestViewPhotoModel{
  Uint8List? uint8listPhoto;
  int photoId;
  TestViewPhotoModel(this.uint8listPhoto,this.photoId);

}