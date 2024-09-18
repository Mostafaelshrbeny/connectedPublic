import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/presentation/blocs/AuthenticationCubit/authentication_state.dart';
import 'package:elconnected/presentation/widgets/signin_form.dart';
import 'package:elconnected/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  int currentScreen = 0;
  bool passwordHidden = true;

  authWidgets() {
    List<Widget> authType = [const SignInForm(), const SignUpForm()];
    return authType[currentScreen];
  }

  showPassword() {
    passwordHidden = !passwordHidden;
    emit(ShowPasswordState());
  }

  changeAuthActions(int action) {
    currentScreen = action;
    passwordHidden = true;
    emit(ChangeActionState());
  }

  signInWithNetwork({required String type, required String token}) async {
    final dio = Dio();
    try {
      final response = await dio.post(ApiConstant.baseUrl + ApiConstant.signIn,
          options: Options(headers: ApiConstant.headers),
          data: {
            "externalProvider": {"type": type, "token": token}
          });
      print(response.data);
    } on DioException catch (e) {
      print(e.response);
    }
  }

  signUpWithNetwork({required String type, required String token}) async {
    final dio = Dio();
    try {
      final response = await dio.post(ApiConstant.baseUrl + ApiConstant.signup,
          options: Options(headers: ApiConstant.headers),
          data: {
            "externalProvider": {"type": type, "token": token}
          });
      print(response.data);
    } on DioException catch (e) {
      print(e.response);
    }
  }
}
