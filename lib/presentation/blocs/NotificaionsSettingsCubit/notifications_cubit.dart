import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/NotificaionsSettingsCubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  bool recommedation = HiveLocaleData.myAppBox?.get("recommedation") ?? true;
  bool specialOffers = HiveLocaleData.myAppBox?.get("specialOffers") ?? true;
  updateNotification({required String setting, required bool enable}) async {
    emit(ChangeNotificationsLoadingState());
    final dio = Dio();
    var data = {
      setting: enable,
    };
    try {
      final response =
          await dio.put(ApiConstant.baseUrl + ApiConstant.updateNotification,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }),
              data: data);
      print(response.data);
      emit(ChangeNotificationsDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      emit(ChangeNotificationsFailedState());
    }
  }

  switchNotificationsSettings({required bool isRecommend}) {
    if (isRecommend) {
      recommedation = !recommedation;
      updateNotification(
          setting: 'isRecommendationsNotificationAllowed',
          enable: recommedation);
      HiveLocaleData.myAppBox?.put("recommedation", recommedation);
    } else {
      specialOffers = !specialOffers;
      updateNotification(
          setting: "isSpecialOffersNotificationAllowed", enable: specialOffers);
      HiveLocaleData.myAppBox?.put("specialOffers", specialOffers);
    }
    emit(SwitchSettingsState());
  }
}
