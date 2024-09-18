import 'package:elconnected/data/models/collection_model.dart';

class RecommendedItemsModel {
  Result? result;
  bool? isSuccess;
  Null message;
  List<Null>? errors;
  String? timestamp;
  int? statusCode;
  Null stackTrace;
  Null innerResult;
  Null correlationId;

  RecommendedItemsModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  RecommendedItemsModel.fromJson(Map<String, dynamic> json) {
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

  Result({this.items});

  Result.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
}

class Items {
  int? totalCount;
  List<ItemsIn>? items;

  Items({this.totalCount, this.items});

  Items.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <ItemsIn>[];
      json['items'].forEach((v) {
        items!.add(ItemsIn.fromJson(v));
      });
    }
  }
}
