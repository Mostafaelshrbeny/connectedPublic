class UserModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  UserModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? refreshToken;
  String? userId;
  bool? isNewUser;
  bool? shouldSkipVerification;
  Verification? verification;
  Contact? contact;

  Result(
      {this.accessToken,
      this.refreshToken,
      this.userId,
      this.isNewUser,
      this.shouldSkipVerification,
      this.verification,
      this.contact});

  Result.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    userId = json['userId'];
    isNewUser = json['isNewUser'];
    shouldSkipVerification = json['shouldSkipVerification'];
    verification = json['verification'] != null
        ? new Verification.fromJson(json['verification'])
        : null;
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }
}

class Verification {
  bool? isEmailVerified;
  bool? isPhoneNumberVerified;
  int? expiredInSeconds;

  Verification(
      {this.isEmailVerified,
      this.isPhoneNumberVerified,
      this.expiredInSeconds});

  Verification.fromJson(Map<String, dynamic> json) {
    isEmailVerified = json['isEmailVerified'];
    isPhoneNumberVerified = json['isPhoneNumberVerified'];
    expiredInSeconds = json['expiredInSeconds'];
  }
}

class Contact {
  String? email;
  String? phoneNumberCode;
  String? phoneNumber;

  Contact({this.email, this.phoneNumberCode, this.phoneNumber});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumberCode = json['phoneNumberCode'];
    phoneNumber = json['phoneNumber'];
  }
}
