import 'package:elconnected/data/models/category_product_model.dart';

class SearchResultModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  SearchResultModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
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
  String? sorting;
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
    }
  }
}

// class ItemsIn {
//   String? id;
//   String? name;
//   String? thumbnailUrl;
//   int? price;

//   Items({this.id, this.name, this.thumbnailUrl, this.price});

//   Items.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     thumbnailUrl = json['thumbnailUrl'];
//     price = json['price'];
//   }

  
// }
