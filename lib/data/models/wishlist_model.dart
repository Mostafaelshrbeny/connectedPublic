import 'package:elconnected/constant/api_constant.dart';

class WishListModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  WishListModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  WishListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = [];
    }
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    stackTrace = json['stackTrace'];
    innerResult = json['innerResult'];
    correlationId = json['correlationId'];
  }
}

class Result {
  List<WishlistItems>? wishlistItems;

  Result({this.wishlistItems});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['wishlistItems'] != null) {
      wishlistItems = <WishlistItems>[];
      json['wishlistItems'].forEach((v) {
        wishlistItems!.add(WishlistItems.fromJson(v));
      });
    } else {
      wishlistItems = <WishlistItems>[];
    }
  }
}

class WishlistItems {
  WItems? items;
  String? creationTime;

  WishlistItems({this.items, this.creationTime});

  WishlistItems.fromJson(Map<String, dynamic> json) {
    items = json['item'] != null ? WItems.fromJson(json['item']) : null;
    creationTime = json['creationTime'];
  }
}

class WItems {
  String? id;
  String? name;
  String? thumbnailUrl;
  String? price;

  WItems({this.id, this.name, this.thumbnailUrl, this.price});

  WItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = ApiConstant.appMedia + json['thumbnailUrl'];
    price = json['price'].toString();
  }
}
