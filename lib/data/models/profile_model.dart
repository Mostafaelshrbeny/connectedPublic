
class ProfileModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String?>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  ProfileModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  Stats? stats;

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
    profilePictureUrl = json['profilePictureUrl'];
    phoneCode = json['phoneCode'];
    phoneNumber = json['phoneNumber'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }
}

class Stats {
  String? pendingItemsCounter;
  String? totalItemsCounter;
  String? totalWishlistItems;

  Stats(
      {this.pendingItemsCounter,
      this.totalItemsCounter,
      this.totalWishlistItems});

  Stats.fromJson(Map<String, dynamic> json) {
    pendingItemsCounter = json['pendingItemsCounter'].toString();
    totalItemsCounter = json['totalItemsCounter'].toString();
    totalWishlistItems = json['totalWishlistItems'].toString();
  }
}
