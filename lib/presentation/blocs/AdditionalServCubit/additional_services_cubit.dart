import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/additional_serv_model.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalServicesCubit extends Cubit<AdditionalServicesState> {
  AdditionalServicesCubit() : super(AdditionalServicesInitial());
  static AdditionalServicesCubit get(context) => BlocProvider.of(context);
  List<int> selectedAdTypes = [];
  bool loading = false;
  final dio = Dio();
  AdditionalServiceModel? service;
  List<Result> allServiceList = [];
  selectAdType(int adTypeIndex) {
    if (selectedAdTypes.contains(adTypeIndex)) {
      selectedAdTypes.removeWhere((element) => element == adTypeIndex);
    } else {
      selectedAdTypes.add(adTypeIndex);
    }
    emit(SelectAdTypeState());
  }

  getAdditionalService(String id) async {
    loading = true;
    emit(GetAdditionaLoadingState());
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/categories/$id/additional-services",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      service = AdditionalServiceModel.fromJson(response.data);
      allServiceList += service?.result ?? [];
      loading = false;
      emit(GetAdditionaDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetAdditionaFailedState());
    }
  }
}
