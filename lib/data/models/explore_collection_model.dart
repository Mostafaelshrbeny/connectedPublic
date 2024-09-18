import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/models/collection_model.dart';

class ExploreCollectionModel {
  Result? result;
  bool? isSuccess;
  Null message;
  List<Null>? errors;
  String? timestamp;
  int? statusCode;
  Null stackTrace;
  Null innerResult;
  Null correlationId;

  ExploreCollectionModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  ExploreCollectionModel.fromJson(Map<String, dynamic> json) {
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
  Collections? collections;
  Null sorting;
  int? skipCount;
  int? maxResultCount;

  Result({this.collections, this.sorting, this.skipCount, this.maxResultCount});

  Result.fromJson(Map<String, dynamic> json) {
    collections = json['collections'] != null
        ? Collections.fromJson(json['collections'])
        : null;
    sorting = json['sorting'];
    skipCount = json['skipCount'];
    maxResultCount = json['maxResultCount'];
  }
}

class Collections {
  int? totalCount;
  List<Items>? items;

  Collections({this.totalCount, this.items});

  Collections.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  int? id;
  String? name;
  String? bannerUrl;
  int? widthRatio;
  int? displayOrder;
  String? mainEmoji;
  bool? isInHome;
  String? type;
  String? backgroundColorCode;
  ActionButton? actionButton;
  List<ItemsIn>? items;

  Items(
      {this.id,
      this.name,
      this.bannerUrl,
      this.widthRatio,
      this.displayOrder,
      this.mainEmoji,
      this.isInHome,
      this.type,
      this.backgroundColorCode,
      this.actionButton,
      this.items});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bannerUrl = json['bannerUrl'] == null
        ? null
        : ApiConstant.appMedia + json['bannerUrl'].toString();
    widthRatio = json['widthRatio'];
    displayOrder = json['displayOrder'];
    mainEmoji = json['mainEmoji'];
    isInHome = json['isInHome'];
    type = json['type'];
    backgroundColorCode = json['backgroundColorCode'];
    actionButton = json['actionButton'] != null
        ? ActionButton.fromJson(json['actionButton'])
        : null;
    if (json['items'] != null) {
      items = <ItemsIn>[];
      json['items'].forEach((v) {
        items!.add(ItemsIn.fromJson(v));
      });
    }
  }
}

class ActionButton {
  String? name;
  String? textColor;
  String? backgroundColor;

  ActionButton({this.name, this.textColor, this.backgroundColor});

  ActionButton.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    textColor = json['textColor'];
    backgroundColor = json['backgroundColor'];
  }
}
