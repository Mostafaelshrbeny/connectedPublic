class AboutAppModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  AboutAppModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  AboutAppModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = null;
    }
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    stackTrace = json['stackTrace'];
    innerResult = json['innerResult'];
    correlationId = json['correlationId'];
  }
}

class Result {
  Result(
      {this.aboutContent,
      this.privacyPolicyContent,
      this.termsAndConditionsContent});

  PrivacyPolicyContent? privacyPolicyContent;
  AboutContent? aboutContent;
  TermsAndConditionsContent? termsAndConditionsContent;

  Result.fromJson(Map<String, dynamic> json) {
    privacyPolicyContent = json['privacyPolicyContent'] != null
        ? PrivacyPolicyContent.fromJson(json['privacyPolicyContent'])
        : null;
    aboutContent = json['aboutContent'] != null
        ? AboutContent.fromJson(json['aboutContent'])
        : null;
    termsAndConditionsContent = json['termsAndConditionsContent'] != null
        ? TermsAndConditionsContent.fromJson(json['termsAndConditionsContent'])
        : null;
  }
}

class AboutContent {
  String? title;
  String? content;

  AboutContent({this.title, this.content});

  AboutContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}

class PrivacyPolicyContent {
  String? title;
  String? content;

  PrivacyPolicyContent({this.title, this.content});

  PrivacyPolicyContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}

class TermsAndConditionsContent {
  String? title;
  String? content;

  TermsAndConditionsContent({this.title, this.content});

  TermsAndConditionsContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}
