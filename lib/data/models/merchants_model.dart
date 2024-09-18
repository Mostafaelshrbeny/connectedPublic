import 'package:elconnected/constant/api_constant.dart';

class MerchantsModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String?>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  MerchantsModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  MerchantsModel.fromJson(Map<String, dynamic> json) {
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
  Merchants? merchants;

  Result({this.merchants});

  Result.fromJson(Map<String, dynamic> json) {
    merchants = json['merchants'] != null
        ? Merchants.fromJson(json['merchants'])
        : null;
  }
}

class Merchants {
  int? totalCount;
  List<Items>? items;

  Merchants({this.totalCount, this.items});

  Merchants.fromJson(Map<String, dynamic> json) {
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
  String? logoUrl;
  String? rating;
  String? ratingsCount;
  bool? isInHome;
  bool? isFeatured;
  String? mainItemUrl;
  String? shortDescription;

  Items(
      {this.id,
      this.name,
      this.logoUrl,
      this.rating,
      this.ratingsCount,
      this.isInHome,
      this.isFeatured,
      this.mainItemUrl,
      this.shortDescription});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoUrl =
        json['logoUrl'] == null ? null : ApiConstant.appMedia + json['logoUrl'];
    rating = json['rating'] == null
        ? null
        : double.parse(json['rating'].toString()).toStringAsFixed(1);
    ratingsCount = json['ratingsCount']?.toString();
    isInHome = json['isInHome'];
    isFeatured = json['isFeatured'];
    mainItemUrl = json['mainItemUrl'] == null
        ? null
        : ApiConstant.appMedia + json['mainItemUrl'];
    shortDescription = json['shortDescription'];
  }
}
