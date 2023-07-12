import 'dart:typed_data';

class GetViewPhotoModel {
  String? createdDate;
  List<ImageList>? imageList;

  GetViewPhotoModel({this.createdDate, this.imageList});

  GetViewPhotoModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    if (json['imageList'] != null) {
      imageList = <ImageList>[];
      json['imageList'].forEach((v) {
        imageList!.add(ImageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    if (imageList != null) {
      data['imageList'] = imageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageList {
  int? id;
  String? imageName;
  String? imagePath;
  String? createdDate;
  String? mode;
  String? longitude;
  String? latitude;
  String? location;
  Uint8List? img;

  ImageList({this.id, this.imageName, this.imagePath, this.createdDate, this.img,
    this.mode,this.longitude,this.latitude,this.location});

  ImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
    mode = json['mode'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    createdDate = "";
    img = null;
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


class TestUploadedPhotoList {
  int? statusCode;
  List<TestUploadedPhotoListData>? testUploadedPhotoListData;

  TestUploadedPhotoList({this.statusCode, this.testUploadedPhotoListData});

  TestUploadedPhotoList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      testUploadedPhotoListData = <TestUploadedPhotoListData>[];
      json['result'].forEach((v) {
        testUploadedPhotoListData!.add(TestUploadedPhotoListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (testUploadedPhotoListData != null) {
      data['result'] = testUploadedPhotoListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestUploadedPhotoListData {
  String? createdDate;
  List<TestImageList>? testImageList;

  TestUploadedPhotoListData({this.createdDate, this.testImageList});

  TestUploadedPhotoListData.fromJson(Map<String, dynamic> json) {
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

  TestImageList(
      {this.id,
        this.imageName,
        this.imagePath,
        this.mode,
        this.longitude,
        this.latitude,
        this.location});

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
