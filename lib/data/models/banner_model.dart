import 'package:elconnected/constant/api_constant.dart';

class BannerModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String?>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  BannerModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  Banners? banners;
  Null sorting;
  int? skipCount;
  int? maxResultCount;

  Result({this.banners, this.sorting, this.skipCount, this.maxResultCount});

  Result.fromJson(Map<String, dynamic> json) {
    banners =
        json['banners'] != null ? Banners.fromJson(json['banners']) : null;
    sorting = json['sorting'];
    skipCount = json['skipCount'];
    maxResultCount = json['maxResultCount'];
  }
}

class Banners {
  int? totalCount;
  List<Items>? items;

  Banners({this.totalCount, this.items});

  Banners.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    } else {
      items = <Items>[];
    }
  }
}

class Items {
  String? id;
  String? imageUrl;
  String? endDate;

  Items({this.id, this.imageUrl, this.endDate});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    imageUrl = ApiConstant.appMedia + json['imageUrl'].toString();
    endDate = json['endDate'];
  }
}
