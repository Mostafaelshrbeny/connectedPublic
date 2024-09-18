import 'package:elconnected/constant/api_constant.dart';

class NotificationsModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  NotificationsModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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
  Notifications? notifications;

  Result({this.notifications});

  Result.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? new Notifications.fromJson(json['notifications'])
        : null;
  }
}

class Notifications {
  int? totalCount;
  List<NotificationItems>? items;

  Notifications({this.totalCount, this.items});

  Notifications.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <NotificationItems>[];
      json['items'].forEach((v) {
        items!.add(new NotificationItems.fromJson(v));
      });
    }
  }
}

class NotificationItems {
  String? title;
  String? message;
  String? imageUrl;
  String? navigationType;
  String? navigationReferenceId;
  String? notificationDate;
  String? timeAgo;

  NotificationItems(
      {this.title,
      this.message,
      this.imageUrl,
      this.navigationType,
      this.navigationReferenceId,
      this.notificationDate,
      this.timeAgo});

  NotificationItems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    imageUrl =
        json['imageUrl'] == null ? "" : ApiConstant.appMedia + json['imageUrl'];
    navigationType = json['navigationType'];
    navigationReferenceId = json['navigationReferenceId'];
    notificationDate = json['notificationDate'];
    timeAgo = json['timeAgo'];
  }
}
