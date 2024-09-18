import 'dart:async';

import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/VerifyCubit/verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());
  static VerificationCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  String? errorMsg;
  int? remain = 0;
  bool canresend = false;
  Timer? timer;
  int secondsRemaining = 0;
  verify({required String code}) async {
    emit(VerificationLoadingState());
    loading = true;
    final dio = Dio();
    try {
      final response = await dio.post(ApiConstant.baseUrl + ApiConstant.verify,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': LocalePref.prefs!.getString("token")
            },
          ),
          data: {"otp": code});
      print(response.data);
      loading = false;
      emit(VerificationDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      errorMsg = e.response!.data['errors'][0].toString();
      loading = false;
      emit(VerificationFailedState());
    }
  }

  resendOTP() async {
    emit(ResendLoadingState());
    loading = false;
    final dio = Dio();
    try {
      final response =
          await dio.post(ApiConstant.baseUrl + ApiConstant.resendOTP,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }),
              data: {});
      print(response.data);
      remain = response.data["expiresInSeconds"];
      loading = false;
      emit(ResendDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      errorMsg =
          e.response!.data['message']?.toString() ?? "Something went wrong";
      emit(ResendFailedState());
    }
  }

  void startTimer(int sec) {
    secondsRemaining = sec;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        emit(TimerState());
      } else {
        resendOption();
        timer.cancel();
        emit(TimerState());
      }
    });
  }

  resendOption() {
    canresend = !canresend;
    emit(ResendOptionState());
  }
}
