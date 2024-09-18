import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/aboutapp_model.dart';
import 'package:elconnected/presentation/blocs/AboutAppCubit/about_app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutAppCubit extends Cubit<AboutAppState> {
  AboutAppCubit() : super(AboutAppInitial());

  static AboutAppCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  String? data, title;
  AboutAppModel? about;
  getData({required String api}) async {
    emit(GetDataLoadingState());

    loading = true;
    final dio = Dio();
    try {
      final response = await dio.get(ApiConstant.baseUrl + api,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      print(response.data);
      loading = false;
      about = AboutAppModel.fromJson(response.data);
      pageString(api: api);
      emit(GetDataDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      emit(GetDataFailedState());
    }
  }

  pageString({required String api}) {
    switch (api) {
      case ApiConstant.about:
        data = about!.result!.aboutContent!.content;
        title = about!.result!.aboutContent!.title;
        break;
      case ApiConstant.privacyNPolicy:
        data = about!.result!.privacyPolicyContent!.content;
        title = about!.result!.privacyPolicyContent!.title;
        break;
      case ApiConstant.termsNCondition:
        data = about!.result!.termsAndConditionsContent!.content;
        title = about!.result!.termsAndConditionsContent!.title;
        break;
      default:
        data = '';
        title = '';
    }
  }
}
