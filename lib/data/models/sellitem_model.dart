class SellitemModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  SellitemModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  SellitemModel.fromJson(Map<String, dynamic> json) {
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
  List<Specifications>? specifications;

  Result({this.specifications});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(Specifications.fromJson(v));
      });
    }
  }
}

class Specifications {
  String? id;
  String? name;
  String? type;
  bool? isRequired;
  bool? allowFiltering;
  bool? showOnProductPage;
  String? displayOrder;
  List<Values>? values;

  Specifications(
      {this.id,
      this.name,
      this.type,
      this.isRequired,
      this.allowFiltering,
      this.showOnProductPage,
      this.displayOrder,
      this.values});

  Specifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isRequired = json['isRequired'];
    allowFiltering = json['allowFiltering'];
    showOnProductPage = json['showOnProductPage'];
    displayOrder = json['displayOrder'].toString();
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }
}

class Values {
  String? from;
  String? to;
  String? id;
  String? value;
  String? fontAwesomeIcon;
  String? name;
  String? website;
  String? logoUrl;

  Values(
      {this.from,
      this.to,
      this.id,
      this.value,
      this.fontAwesomeIcon,
      this.name,
      this.website,
      this.logoUrl});

  Values.fromJson(Map<String, dynamic> json) {
    from = json['from']?.toString();
    to = json['to'].toString();
    id = json['id'];
    value = json['value'];
    fontAwesomeIcon = json['fontAwesomeIcon'];
    name = json['name'];
    website = json['website'];
    logoUrl = json['logoUrl'];
  }
}
