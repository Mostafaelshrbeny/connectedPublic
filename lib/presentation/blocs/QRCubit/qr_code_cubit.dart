import 'dart:convert';

import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/models/qr_model.dart';
import 'package:elconnected/presentation/blocs/QRCubit/qr_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeInitial());
  static QrCodeCubit get(context) => BlocProvider.of(context);
  QRModel? qrRes;
  Image? qrCode;
  bool loading = false;
  getQR() async {
    final dio = Dio();
    loading = true;
    emit(GetQrCodeLoadingState());
    try {
      final response =
          await dio.get("${ApiConstant.baseUrl}/mobile/api/accounts/qr",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }));
      qrRes = QRModel.fromJson(response.data);
      qrCode = imageFromBase64String(qrRes?.result?.qrCodeBase64);
      loading = false;
      emit(GetQrCodeDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetQrCodeFailedState());
    }
  }

  Image? imageFromBase64String(String? base64String) {
    if (base64String == null) {
      return null;
    } else {
      return Image.memory(base64Decode(base64String));
    }
  }
}
