import 'dart:convert';
import 'dart:io';

import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/domain/use_cases/sell_functions.dart';
import 'package:image_picker/image_picker.dart';

class SellDetails {
  static String? categoryId, getInTouchWithOption;
  static String? title, description, thumbnail, voucherCode;
  static List<String> photos = [];
  static List<String> videos = [];
  static List<String> specificationValueIds = [];
  static List<String> additionalServices = [];
  static double? lat, long;
  static double? price;
  static reset() {
    photos = [];
    videos = [];
    categoryId = null;
    getInTouchWithOption = null;
    title = null;
    description = null;
    thumbnail = null;
    voucherCode = null;
    specificationValueIds = [];
    additionalServices = [];
    price = null;
  }

  setAdditional() {}
  static setCatId(String id) {
    categoryId = id;
  }

  static setData(
      {required String itemTitle,
      required String itemDesc,
      String? itemThumb,
      String? voucher,
      required String code,
      required String phone,
      required double itemPrice}) {
    title = itemTitle;
    description = itemDesc;
    thumbnail = itemThumb;
    voucherCode = voucher;
    price = itemPrice;
  }

  static convertMedia(List<XFile> images) async {
    List<String> convertedMedia = [];
    List<File> newImages = [];
    List<String> uploadedImages = [];
    for (var element in images) {
      newImages.add(File(element.path));
    }
    for (var image in newImages) {
      List<int> imageBytes = image.readAsBytesSync();

      String base64Image = base64Encode(imageBytes);
      convertedMedia.add(base64Image);
    }
    uploadedImages = await uploadas(convertedMedia);
    return uploadedImages;
  }

  static setlocationData(
      {required double locationlat, required double locationlong}) {
    lat = locationlat;
    long = locationlong;
  }

  static setMedia(
      {required List<XFile>? ximages,
      required List<XFile>? xFilevideos}) async {
    ximages == null ? null : photos += await convertMedia(ximages);
    xFilevideos == null ? null : videos = await convertMedia(xFilevideos);
  }

  static removeImage(int index) {
    photos.removeAt(index);
  }

  static uploadas(List<String> convertedMedia) async {
    List<String> uploadedImages = [];
    for (var element in convertedMedia) {
      print(element);
      print("+++++++++++++++++++++++++++++++++++++++++++++++");
      uploadedImages.add(await SellFunctions.uploadasync(element,
          element.split('')[0] + element.split('')[1] + element.split('')[2]));
    }
    return uploadedImages;
  }

  static setValue(List<String> newVal) {
    specificationValueIds = newVal;
  }
}

class SetDetailes {
  static Map<String, dynamic> data = {
    "categoryId": int.parse(SellDetails.categoryId!),
    "title": "${SellDetails.title}",
    "description": "${SellDetails.description}",
    "photos": SellDetails.photos.map((photo) => "$photo").toList(),
    "thumbnail": (SellDetails.photos.isNotEmpty)
        ? SellDetails.photos.first
        : '', // first image,
    "videos": SellDetails.videos,
    "specificationValueIds":
        SellDetails.specificationValueIds.map((id) => "$id").toList(), // []
    "location": {"locationId": 5, "lat": 30.033333, "lon": 31.233334},
    "phoneNumber": {
      "code": PhoneCode.code != null ? "${PhoneCode.code}" : "${"+20"}",
      "number": PhoneCode.phone != null ? "${PhoneCode.phone}" : ""
    },
    "price": SellDetails.price,
    "getInTouchWithOption": SellDetails.getInTouchWithOption ?? 0,
    "additionalServices":
        SellDetails.additionalServices.map((service) => "$service").toList(),
    "voucherCode":
        SellDetails.voucherCode != null ? "${SellDetails.voucherCode}" : ""
  };
}
