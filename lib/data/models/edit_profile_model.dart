import 'package:elconnected/constant/api_constant.dart';

class EditProfileModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  EditProfileModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
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
  UserProfile? userProfile;

  Result({this.userProfile});

  Result.fromJson(Map<String, dynamic> json) {
    userProfile = json['userProfile'] != null
        ? UserProfile.fromJson(json['userProfile'])
        : null;
  }
}

class UserProfile {
  String? firstName;
  String? lastName;
  String? email;
  String? profilePictureUrl;
  String? phoneCode;
  String? phoneNumber;
  dynamic stats;

  UserProfile(
      {this.firstName,
      this.lastName,
      this.email,
      this.profilePictureUrl,
      this.phoneCode,
      this.phoneNumber,
      this.stats});

  UserProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profilePictureUrl = json['profilePictureUrl'] == null
        ? null
        : ApiConstant.appMedia + json['profilePictureUrl'];
    phoneCode = json['phoneCode'];
    phoneNumber = json['phoneNumber'];
    stats = json['stats'];
  }
}
