import 'package:elconnected/constant/api_constant.dart';

class AllCategoriesModel {
  Result? result;
  bool? isSuccess;
  Null message;
  List? errors;
  String? timestamp;
  int? statusCode;
  Null stackTrace;
  Null innerResult;
  Null correlationId;

  AllCategoriesModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;

  Result({this.categories});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    } else {
      categories = <Categories>[];
    }
  }
}

class Categories {
  String? id;
  String? name;
  String? imageUrl;
  int? widthRatio;

  Categories({this.id, this.name, this.imageUrl, this.widthRatio});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = ApiConstant.appMedia + json['imageUrl'];
    widthRatio = json['widthRatio'];
  }
}
