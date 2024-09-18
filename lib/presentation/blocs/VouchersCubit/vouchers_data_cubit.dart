import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/vouchers_model.dart';
import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VouchersDataCubit extends Cubit<VouchersDataState> {
  VouchersDataCubit() : super(VouchersDataInitial());
  static VouchersDataCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  int skipItems = 0;
  String? erroMsg;
  int currentvoucher = 0;
  VouchersModel? vouchers;
  final dio = Dio();
  List<Items> vouchersList = [];
  getAllVouchers(int skip) async {
    emit(GetVouchersDataLoadingState());
    loading = true;

    try {
      final response = await dio.get(
          '${ApiConstant.baseUrl}/mobile/api/vouchers?SkipCount=$skip&MaxResultCount=10',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      vouchers = VouchersModel.fromJson(response.data);
      vouchersList += vouchers?.result?.vouchers?.items ?? [];
      loading = false;
      emit(GetVouchersDataDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetVouchersDataFailedState());
    }
  }

  scroll() {
    skipItems += 10;
    getAllVouchers(skipItems);
    emit(VouchersScrollState());
  }

  sellItem() async {
    emit(SellLoadingState());
    print(SetDetailes.data);
    try {
      final response = await dio.post("${ApiConstant.baseUrl}/mobile/api/items",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: jsonEncode(SetDetailes.data));
      print(response.data);
      emit(SellDoneState());
    } on DioException catch (e) {
      print(e.response);
      print(jsonEncode(SetDetailes.data));
      erroMsg = e.response?.data['errors'][0] ?? '';
      emit(SellFailedState());
    }
  }

  selectVoucher(int index) {
    currentvoucher = index;
    emit(SelectVoucherState());
  }
}
