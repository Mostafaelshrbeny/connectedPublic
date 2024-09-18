import 'package:elconnected/constant/api_constant.dart';

class AdditionalServiceModel {
  List<Result>? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  AdditionalServiceModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  AdditionalServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
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
  String? id;
  String? name;
  String? description;
  String? price;
  String? icon;

  Result({this.id, this.name, this.description, this.price, this.icon});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    description = json['description'];
    price = json['price'].toString();
    icon = json['icon'] == null ? '' : ApiConstant.appMedia + json['icon'];
  }
}
