import 'package:elconnected/constant/api_constant.dart';

class CategoryProductModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String?>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  CategoryProductModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
    message = json['message'];

    errors = [];

    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    stackTrace = json['stackTrace'];
    innerResult = json['innerResult'];
    correlationId = json['correlationId'];
  }
}

class Result {
  Items? items;
  Null sorting;
  int? skipCount;
  int? maxResultCount;

  Result({this.items, this.sorting, this.skipCount, this.maxResultCount});

  Result.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    sorting = json['sorting'];
    skipCount = json['skipCount'];
    maxResultCount = json['maxResultCount'];
  }
}

class Items {
  int? totalCount;
  List<ItemsINCategory>? items;

  Items({this.totalCount, this.items});

  Items.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <ItemsINCategory>[];
      json['items'].forEach((v) {
        items!.add(ItemsINCategory.fromJson(v));
      });
    } else {
      items = <ItemsINCategory>[];
    }
  }
}

class ItemsINCategory {
  String? id;
  String? name;
  String? thumbnailUrl;
  String? price;

  ItemsINCategory({this.id, this.name, this.thumbnailUrl, this.price});

  ItemsINCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = ApiConstant.appMedia + json['thumbnailUrl'].toString();
    price = json['price']?.toString();
  }
}
