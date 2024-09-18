import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/async_model.dart';

class SellFunctions {
  static uploadasync(String image64, String newPath) async {
    final dio = Dio();
    AsyncMediaModel? resModel;
    try {
      final response = await dio.post(
          ApiConstant.baseUrl + ApiConstant.uploadAsync,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {
            "fileName": newPath,
            "content": image64,
            "contentType": "image/jpg"
          });
      print(response.data);
      resModel = AsyncMediaModel.fromJson(response.data);
      return "${resModel.result?.url}";
    } on DioException catch (e) {
      print(e.response);
      return '';
    }
  }
}
