// class ProductDetailsModel {
//   Result? result;
//   bool? isSuccess;
//   String? message;
//   List<String>? errors;
//   String? timestamp;
//   int? statusCode;
//   String? stackTrace;
//   String? innerResult;
//   String? correlationId;

//   ProductDetailsModel(
//       {this.result,
//       this.isSuccess,
//       this.message,
//       this.errors,
//       this.timestamp,
//       this.statusCode,
//       this.stackTrace,
//       this.innerResult,
//       this.correlationId});

//   ProductDetailsModel.fromJson(Map<String, dynamic> json) {
//     result =
//         json['result'] != null ? new Result.fromJson(json['result']) : null;
//     isSuccess = json['isSuccess'];
//     message = json['message'];
    
//       errors = [];
     
    
//     timestamp = json['timestamp'];
//     statusCode = json['statusCode'];
//     stackTrace = json['stackTrace'];
//     innerResult = json['innerResult'];
//     correlationId = json['correlationId'];
//   }

  
// }

// class Result {
//   Item? item;

//   Result({this.item});

//   Result.fromJson(Map<String, dynamic> json) {
//     item = json['item'] != null ? new Item.fromJson(json['item']) : null;
//   }

  
// }

// class Item {
//   int? id;
//   String? thumbnailUrl;
//   int? price;
//   String? title;
//   String? description;
//   int? categoryId;
//   List<Specifications>? specifications;

//   Item(
//       {this.id,
//       this.thumbnailUrl,
//       this.price,
//       this.title,
//       this.description,
//       this.categoryId,
//       this.specifications});

//   Item.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     thumbnailUrl = json['thumbnailUrl'];
//     price = json['price'];
//     title = json['title'];
//     description = json['description'];
//     categoryId = json['categoryId'];
//     if (json['specifications'] != null) {
//       specifications = <Specifications>[];
//       json['specifications'].forEach((v) {
//         specifications!.add(new Specifications.fromJson(v));
//       });
//     }
//   }

  
// }

// class Specifications {
//   String? specificationId;
//   String? name;
//   bool? isRequired;
//   bool? allowFiltering;
//   bool? showOnProductPage;
//   int? displayOrder;
//   String? type;
//   List<SpecificationValues>? specificationValues;

//   Specifications(
//       {this.specificationId,
//       this.name,
//       this.isRequired,
//       this.allowFiltering,
//       this.showOnProductPage,
//       this.displayOrder,
//       this.type,
//       this.specificationValues});

//   Specifications.fromJson(Map<String, dynamic> json) {
//     specificationId = json['specificationId'];
//     name = json['name'];
//     isRequired = json['isRequired'];
//     allowFiltering = json['allowFiltering'];
//     showOnProductPage = json['showOnProductPage'];
//     displayOrder = json['displayOrder'];
//     type = json['type'];
//     if (json['specificationValues'] != null) {
//       specificationValues = <SpecificationValues>[];
//       json['specificationValues'].forEach((v) {
//         specificationValues!.add(new SpecificationValues.fromJson(v));
//       });
//     }
//   }

  
// }

// class SpecificationValues {
//   String? specificationValueId;
//   String? value;
//   String? type;
//   String? formattedValue;
//   Null? color;
//   Null? colorCode;
//   String? fontAwesomeIcon;
//   String? logoUrl;
//   String? website;
//   String? name;
//   int? from;
//   int? to;
//   Null? brand;
//   List<Null>? models;

//   SpecificationValues(
//       {this.specificationValueId,
//       this.value,
//       this.type,
//       this.formattedValue,
//       this.color,
//       this.colorCode,
//       this.fontAwesomeIcon,
//       this.logoUrl,
//       this.website,
//       this.name,
//       this.from,
//       this.to,
//       this.brand,
//       this.models});

//   SpecificationValues.fromJson(Map<String, dynamic> json) {
//     specificationValueId = json['specificationValueId'];
//     value = json['value'];
//     type = json['type'];
//     formattedValue = json['formattedValue'];
//     color = json['color'];
//     colorCode = json['colorCode'];
//     fontAwesomeIcon = json['fontAwesomeIcon'];
//     logoUrl = json['logoUrl'];
//     website = json['website'];
//     name = json['name'];
//     from = json['from'];
//     to = json['to'];
//     brand = json['brand'];
//     if (json['models'] != null) {
//       models = <Null>[];
//       json['models'].forEach((v) {
//         models!.add(new Null.fromJson(v));
//       });
//     }
//   }

  
// }
