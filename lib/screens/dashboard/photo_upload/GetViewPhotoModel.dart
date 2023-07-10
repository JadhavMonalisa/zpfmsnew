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

