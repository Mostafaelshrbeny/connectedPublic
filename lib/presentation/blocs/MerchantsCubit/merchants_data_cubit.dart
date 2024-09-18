import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/merchants_model.dart';
import 'package:elconnected/presentation/blocs/MerchantsCubit/merchants_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MerchantsDataCubit extends Cubit<MerchantsDataState> {
  MerchantsDataCubit() : super(MerchantsDataInitial());
  static MerchantsDataCubit get(context) => BlocProvider.of(context);
  MerchantsModel? allMerchants;
  List<Items> merchantsList = [];
  int skipItems = 0;
  bool loading = false;
  getMerchants(int skip) async {
    final dio = Dio();
    emit(GetMerchantLoadingState());
    loading = true;
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/merchants?IsInHome=true&IsFeatured=true&SkipCount=$skip&MaxResultCount=10",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));

      allMerchants = MerchantsModel.fromJson(response.data);
      merchantsList += allMerchants?.result?.merchants?.items ?? [];
      loading = false;
      emit(GetMerchantDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetMerchantFailedState());
    }
  }

  scroll() {
    skipItems += 10;
    getMerchants(skipItems);
    emit(MerchantScrollState());
  }
}
