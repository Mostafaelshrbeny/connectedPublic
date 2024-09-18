import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/AccountPrivacy/account_privacy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPrivacyCubit extends Cubit<AccountPrivacyState> {
  AccountPrivacyCubit() : super(AccountPrivacyInitial());
  static AccountPrivacyCubit get(context) => BlocProvider.of(context);
  bool changePassword = false;
  bool oldpasswordHidden = true;
  bool newpasswordHidden = true;
  bool confirmpasswordHidden = true;
  startChangingPassword() {
    changePassword = !changePassword;
    emit(ChangingPasswordState());
  }

  oldpasswordVisibility() {
    oldpasswordHidden = !oldpasswordHidden;
    emit(PasswordVisibilityState());
  }

  newpasswordVisibility() {
    newpasswordHidden = !newpasswordHidden;
    emit(PasswordVisibilityState());
  }

  confirmpasswordVisibility() {
    confirmpasswordHidden = !confirmpasswordHidden;
    emit(PasswordVisibilityState());
  }

  updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final dio = Dio();
    var data = {
      "currentPassword": oldPassword,
      "newPassword": newPassword,
      "confirmNewPassword": newPassword
    };
    try {
      final response =
          await dio.put(ApiConstant.baseUrl + ApiConstant.updatePassword,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }),
              data: data);
      print(response.data);
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
