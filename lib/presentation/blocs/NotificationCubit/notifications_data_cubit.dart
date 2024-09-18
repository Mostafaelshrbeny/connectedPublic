import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/notifications_model.dart';
import 'package:elconnected/presentation/blocs/NotificationCubit/notifications_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsDataCubit extends Cubit<NotificationsDataState> {
  NotificationsDataCubit() : super(NotificationsDataInitial());
  static NotificationsDataCubit get(context) => BlocProvider.of(context);
  NotificationsModel? notification;
  List<NotificationItems> notificationList = [];
  bool loading = false;
  getNotifications() async {
    final dio = Dio();
    loading = true;
    emit(GetNotificationsDataLoadingState());
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/notifications?UseFake=true",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      notification = NotificationsModel.fromJson(response.data);
      notificationList += notification?.result?.notifications?.items ?? [];
      print(response.data);
      loading = false;
      emit(GetNotificationsDataDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetNotificationsDataFailedState());
    }
  }
}
