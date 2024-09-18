import 'package:elconnected/constant/api_constant.dart';

class GridItemsModel {
  Result? result;
  bool? isSuccess;
  String? message;
  List<String>? errors;
  String? timestamp;
  int? statusCode;
  String? stackTrace;
  String? innerResult;
  String? correlationId;

  GridItemsModel(
      {this.result,
      this.isSuccess,
      this.message,
      this.errors,
      this.timestamp,
      this.statusCode,
      this.stackTrace,
      this.innerResult,
      this.correlationId});

  GridItemsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = [];
    }
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    stackTrace = json['stackTrace'];
    innerResult = json['innerResult'];
    correlationId = json['correlationId'];
  }
}

class Result {
  RecentlyViewedItems? recentlyViewedItems;
  SharedItems? sharedItems;
  List<WishlistItems>? wishlistItems;

  Result({this.recentlyViewedItems, this.wishlistItems, this.sharedItems});

  Result.fromJson(Map<String, dynamic> json) {
    recentlyViewedItems = json['recentlyViewedItems'] != null
        ? RecentlyViewedItems.fromJson(json['recentlyViewedItems'])
        : null;
    sharedItems = json['sharedItems'] != null
        ? SharedItems.fromJson(json['sharedItems'])
        : null;
    if (json['wishlistItems'] != null) {
      wishlistItems = <WishlistItems>[];
      json['wishlistItems'].forEach((v) {
        wishlistItems!.add(WishlistItems.fromJson(v));
      });
    } else {
      wishlistItems = null;
    }
  }
}

class RecentlyViewedItems {
  List<Items>? items;
  int? totalCount;

  RecentlyViewedItems({this.items, this.totalCount});

  RecentlyViewedItems.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    } else {
      items = <Items>[];
    }
    totalCount = json['totalCount'];
  }
}

class SharedItems {
  List<Items>? items;
  int? totalCount;

  SharedItems({this.items, this.totalCount});

  SharedItems.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    } else {
      items = <Items>[];
    }
    totalCount = json['totalCount'];
  }
}

class WishlistItems {
  WishItems? items;
  String? creationTime;

  WishlistItems({this.items, this.creationTime});

  WishlistItems.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? WishItems.fromJson(json['items']) : null;
    creationTime = json['creationTime'];
  }
}

class Items {
  String? id;
  String? name;
  String? thumbnailUrl;
  double? price;

  Items({this.id, this.name, this.thumbnailUrl, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = ApiConstant.appMedia + json['thumbnailUrl'];
    price = json['price'];
  }
}

class WishItems {
  String? id;
  String? name;
  String? thumbnailUrl;
  int? price;

  WishItems({this.id, this.name, this.thumbnailUrl, this.price});

  WishItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = json['thumbnailUrl'];
    price = json['price'];
  }
}
