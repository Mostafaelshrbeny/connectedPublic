class VouchersModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  VouchersModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  VouchersModel.fromJson(Map<String, dynamic> json) {
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
  Vouchers? vouchers;

  Result({this.vouchers});

  Result.fromJson(Map<String, dynamic> json) {
    vouchers =
        json['vouchers'] != null ? Vouchers.fromJson(json['vouchers']) : null;
  }
}

class Vouchers {
  int? totalCount;
  List<Items>? items;

  Vouchers({this.totalCount, this.items});

  Vouchers.fromJson(Map<String, dynamic> json) {
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
  String? id;
  Title? title;
  Title? description;
  Title? discountText;
  Title? balanceText;
  Appearance? appearance;
  Metadata? metadata;
  bool? isActive;
  ComputationalData? computationalData;

  Items(
      {this.id,
      this.title,
      this.description,
      this.discountText,
      this.balanceText,
      this.appearance,
      this.metadata,
      this.isActive,
      this.computationalData});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Title.fromJson(json['description'])
        : null;
    discountText = json['discountText'] != null
        ? Title.fromJson(json['discountText'])
        : null;
    balanceText = json['balanceText'] != null
        ? Title.fromJson(json['balanceText'])
        : null;
    appearance = json['appearance'] != null
        ? Appearance.fromJson(json['appearance'])
        : null;
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    isActive = json['isActive'];
    computationalData = json['computationalData'] != null
        ? ComputationalData.fromJson(json['computationalData'])
        : null;
  }
}

class Title {
  String? text;
  String? color;

  Title({this.text, this.color});

  Title.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    color = json['color'];
  }
}

class Appearance {
  String? backgroundColor;
  String? borderColor;
  double? borderThickness;

  Appearance({this.backgroundColor, this.borderColor, this.borderThickness});

  Appearance.fromJson(Map<String, dynamic> json) {
    backgroundColor = json['backgroundColor'];
    borderColor = json['borderColor'];
    borderThickness = json['borderThickness'] == null
        ? 0.0
        : double.parse(json['borderThickness'].toString());
  }
}

class Metadata {
  String? code;
  String? startDate;
  String? endDate;

  Metadata({this.code, this.startDate, this.endDate});

  Metadata.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }
}

class ComputationalData {
  String? maximumDiscount;
  bool? isPercentageDiscount;
  String? minimumPrice;

  ComputationalData(
      {this.maximumDiscount, this.isPercentageDiscount, this.minimumPrice});

  ComputationalData.fromJson(Map<String, dynamic> json) {
    maximumDiscount = json['maximumDiscount']?.toString();
    isPercentageDiscount = json['isPercentageDiscount'];
    minimumPrice = json['minimumPrice']?.toString();
  }
}
