import 'package:elconnected/constant/api_constant.dart';

class ItemDetailsModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  ItemDetailsModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  ItemDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Item? item;

  Result({this.item});

  Result.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
}

class Item {
  int? id;
  String? thumbnailUrl;
  String? price;
  String? title;
  String? description;
  int? categoryId;
  List<Specifications>? specifications;
  Location? location;
  List<String>? media = [];

  Item(
      {this.id,
      this.thumbnailUrl,
      this.price,
      this.title,
      this.description,
      this.categoryId,
      this.specifications,
      this.location,
      this.media});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'] == null
        ? null
        : ApiConstant.appMedia + json['thumbnailUrl'];
    price = json['price'].toString();
    title = json['title'];
    description = json['description'];
    categoryId = json['categoryId'];
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(Specifications.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    // media = json['media'].cast<String>();
    for (var element in json['media']) {
      media!.add(ApiConstant.appMedia + element);
    }
  }
}

class Specifications {
  String? specificationId;
  String? name;
  bool? isRequired;
  bool? allowFiltering;
  bool? showOnProductPage;
  int? displayOrder;
  String? type;
  List<SpecificationValues>? specificationValues;

  Specifications(
      {this.specificationId,
      this.name,
      this.isRequired,
      this.allowFiltering,
      this.showOnProductPage,
      this.displayOrder,
      this.type,
      this.specificationValues});

  Specifications.fromJson(Map<String, dynamic> json) {
    specificationId = json['specificationId'];
    name = json['name'];
    isRequired = json['isRequired'];
    allowFiltering = json['allowFiltering'];
    showOnProductPage = json['showOnProductPage'];
    displayOrder = json['displayOrder'];
    type = json['type'];
    if (json['specificationValues'] != null) {
      specificationValues = <SpecificationValues>[];
      json['specificationValues'].forEach((v) {
        specificationValues!.add(SpecificationValues.fromJson(v));
      });
    }
  }
}

class SpecificationValues {
  String? specificationValueId;
  String? value;
  String? type;
  String? formattedValue;
  Null color;
  Null colorCode;
  String? fontAwesomeIcon;
  String? logoUrl;
  String? website;
  String? name;
  String? from;
  String? to;

  SpecificationValues(
      {this.specificationValueId,
      this.value,
      this.type,
      this.formattedValue,
      this.color,
      this.colorCode,
      this.fontAwesomeIcon,
      this.logoUrl,
      this.website,
      this.name,
      this.from,
      this.to});

  SpecificationValues.fromJson(Map<String, dynamic> json) {
    specificationValueId = json['specificationValueId'];
    value = json['value'];
    type = json['type'];
    formattedValue = json['formattedValue'];
    color = json['color'];
    colorCode = json['colorCode'];
    fontAwesomeIcon = json['fontAwesomeIcon'];
    logoUrl =
        json['logoUrl'] == null ? null : ApiConstant.appMedia + json['logoUrl'];
    website = json['website'];
    name = json['name'];
    from = json['from'].toString();
    to = json['to'].toString();
  }
}

class Location {
  int? id;
  String? name;
  double? lon;
  double? lat;

  Location({this.id, this.name, this.lon, this.lat});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lon = json['lon'];
    lat = json['lat'];
  }
}
