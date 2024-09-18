import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/allcategories_model.dart';
import 'package:elconnected/data/models/home_collection_model.dart';
import 'package:elconnected/data/models/merchants_model.dart';
import 'package:elconnected/data/models/recommended_model.dart';

class HomeDataMethods {
  static final dio = Dio();
  static getCategories() async {
    final response = await dio.get(ApiConstant.baseUrl + ApiConstant.categories,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    return AllCategoriesModel.fromJson(response.data);
  }

  static getMerchants() async {
    final response = await dio.get(ApiConstant.baseUrl + ApiConstant.merchants,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));

    return MerchantsModel.fromJson(response.data);
  }

  static getRecommended({required int skip, required int max}) async {
    final response = await dio.get(
        '${ApiConstant.baseUrl}/mobile/api/items/recommended?SkipCount=$skip&MaxResultCount=$max',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    return RecommendedItemsModel.fromJson(response.data);
  }

  static getHomecollection() async {
    final response = await dio.get(
        "${ApiConstant.baseUrl}/mobile/api/collections?IsInHome=true&ShouldIncludeItems=false",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    return HomeCollectionModel.fromJson(response.data);
  }
}
