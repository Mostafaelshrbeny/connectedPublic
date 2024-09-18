import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/ManageAccount/manage_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageAccountCubit extends Cubit<ManageAccountState> {
  ManageAccountCubit() : super(ManageAccountInitial());
  static ManageAccountCubit get(context) => BlocProvider.of(context);
  bool deletingAccount = false;
  bool passwordHidden = true;
  String? deviceUUID;
  bool loading = false;
  final dio = Dio();
  switchToDelete() {
    deletingAccount = !deletingAccount;
    emit(SwithToDeletingState());
  }

  showPassword() {
    passwordHidden = !passwordHidden;
    emit(ShowPasswordState());
  }

  deleteAccount({required String password}) async {
    emit(DeleteLoadingState());
    loading = true;
    try {
      final response = await dio.delete(
        '${ApiConstant.baseUrl}${ApiConstant.deleteAccount}?Password=$password',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }),
      );
      print(response.data);
      loading = false;
      emit(DeleteDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      emit(DeleteFailedState());
    }
  }

  logOut() async {
    deviceUUID = await getId();
    try {
      final response =
          await dio.post("${ApiConstant.baseUrl}/mobile/api/accounts/logout",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }),
              data: {"deviceUUID": deviceUUID});
      print(response.data);
    } on DioException catch (e) {
      print(e.response);
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
