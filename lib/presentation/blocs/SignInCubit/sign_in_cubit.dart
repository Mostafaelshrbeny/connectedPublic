import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/profile_model.dart';
import 'package:elconnected/data/models/user_model.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/domain/use_cases/save_token.dart';
import 'package:elconnected/presentation/blocs/SignInCubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  static SignInCubit get(context) => BlocProvider.of(context);
  String? uuid;
  bool loading = false;
  String? errorMsg;
  bool verified = false;
  UserModel? user;
  ProfileModel? userProfile;
  int? second;
  final dio = Dio();
  userlogin({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    loading = true;
    uuid = await getId();
    var data = {
      "email": email,
      "password": password,
      "token": {
        "deviceUUID": "${uuid}",
        "deviceType": Platform.isAndroid ? "andriod" : "ios",
        "fcmToken": "${SaveToken.fcmToken}"
      }
    };
    await login(data);
  }

  login(var data) async {
    try {
      final response = await dio.post(ApiConstant.baseUrl + ApiConstant.signIn,
          options: Options(
            headers: ApiConstant.headers,
          ),
          data: data);
      print(response.data);
      user = UserModel.fromJson(response.data);

      verified = user?.result?.verification?.isPhoneNumberVerified ?? true;
      second = user?.result?.verification?.expiredInSeconds;
      PhoneCode.setCode(
          newCode: user!.result!.contact!.phoneNumberCode!,
          pNumber: user!.result!.contact!.phoneNumber!);
      HiveLocaleData.myAppBox!.put('notuser', false);
      await SaveToken.saveUser('bearer ${user!.result!.accessToken!}');
      await SaveToken.saveUser('bearer ${user!.result!.accessToken!}');
      print(LocalePref.prefs!.getString("token"));

      await SaveToken.refreshToken(user!.result!.refreshToken!);
      Future.delayed(const Duration(seconds: 1));
      await getProfile();
      loading = false;
      emit(SignInDoneState());
    } on DioException catch (e) {
      print(e.response);
      errorMsg = e.response?.data["message"]?.toString();
      loading = false;
      emit(SignInFailedState());
    }
  }

  getProfile() async {
    emit(GetProfileLoadingState());
    try {
      final response = await dio.get(ApiConstant.baseUrl + ApiConstant.account,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      print(response.data);
      userProfile = ProfileModel.fromJson(response.data);
      await SaveUserData.savedata(userProfile);
      emit(GetProfileDoneState());
    } on DioException catch (e) {
      print(e.response);
      print('+++++++++++++++++++++++++++++');
      emit(GetProfileFailedState());
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
