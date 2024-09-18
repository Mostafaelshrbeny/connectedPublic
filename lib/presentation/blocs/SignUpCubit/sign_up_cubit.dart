import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/user_model.dart';
import 'package:elconnected/domain/use_cases/save_token.dart';
import 'package:elconnected/presentation/blocs/SignUpCubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);
  String? errorMsg;
  bool loading = false;
  bool verified = false;
  String? uuid;
  UserModel? user;
  int? second;
  userSignup(
      {required String email,
      required String code,
      required String firstName,
      required String lastName,
      required String phone,
      required String password,
      required String provider,
      required String providerToken}) async {
    emit(SignUpLoadingState());
    uuid = await getId();
    loading = true;
    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": {"code": code, "number": phone},
      "password": password,
      "token": {
        "deviceUUID": "${uuid}",
        "deviceType": Platform.isAndroid ? "andriod" : "ios",
        "fcmToken": "${SaveToken.fcmToken}"
      }
    };

    print(data);
    await signUpRequest(data);
  }

  signUpRequest(var data) async {
    final dio = Dio();
    try {
      final response = await dio.post(ApiConstant.baseUrl + ApiConstant.signup,
          options: Options(
            headers: ApiConstant.headers,
          ),
          data: data);
      print(response.data);
      user = UserModel.fromJson(response.data);
      loading = false;
      SaveToken.saveUser('bearer ${user!.result!.accessToken!}');
      SaveToken.refreshToken('bearer ${user!.result!.refreshToken!}');
      HiveLocaleData.myAppBox!.put('notuser', false);
      verified = user?.result?.verification?.isPhoneNumberVerified ?? true;
      second = user?.result?.verification?.expiredInSeconds;
      emit(SignUpDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      errorMsg =
          e.response?.data["errors"][0]?.toString() ?? "SomeThing went wrong";
      emit(SignUpFailedState());
    }
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    } else {
      return "";
    }
  }
}
