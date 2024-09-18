class AsyncMediaModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  AsyncMediaModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  AsyncMediaModel.fromJson(Map<String, dynamic> json) {
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
  String? referenceUrl;
  String? source;
  String? url;
  String? baseUrl;
  String? cdnUrl;

  Result({this.referenceUrl, this.source, this.url, this.baseUrl, this.cdnUrl});

  Result.fromJson(Map<String, dynamic> json) {
    referenceUrl = json['referenceUrl'];
    source = json['source'];
    url = json['url'];
    baseUrl = json['baseUrl'];
    cdnUrl = json['cdnUrl'];
  }
}
