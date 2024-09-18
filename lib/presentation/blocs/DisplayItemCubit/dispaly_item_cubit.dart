import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/item_details_model.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/DisplayItemCubit/dispaly_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispalyItemCubit extends Cubit<DispalyItemState> {
  DispalyItemCubit() : super(DispalyItemInitial());
  static DispalyItemCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  final dio = Dio();
  ItemDetailsModel? itemData;
  viewItem(int id) async {
    try {
      await dio.post("${ApiConstant.baseUrl}/mobile/api/items/$id/view",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {});
      emit(ViewItemDone());
    } on DioException catch (e) {
      print(e.response);
      emit(ViewItemFailed());
    }
  }

  like(int id) {
    ItemActions.addItem(id);
    emit(LoveThisItem());
  }

  likeProduct(int id) async {
    try {
      await dio.post("${ApiConstant.baseUrl}/mobile/api/items/$id/wishlist",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {});
      emit(LoveThisItemDone());
    } on DioException catch (e) {
      print(e.response);
      emit(LoveThisItemFailed());
    }
  }

  shareItem(int id) async {
    try {
      await dio.post("${ApiConstant.baseUrl}/mobile/api/items/$id/share",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {});
      emit(ShareItemDone());
    } on DioException catch (e) {
      print(e.response);
      emit(ShareItemFailed());
    }
  }

  getItemDetails(int id) async {
    emit(GetItemDataLoading());
    loading = true;
    try {
      final response =
          await dio.get("${ApiConstant.baseUrl}/mobile/api/items/$id",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }));
      itemData = ItemDetailsModel.fromJson(response.data);
      loading = false;
      print(response.data);
      emit(GetItemDataDone());
    } on DioException catch (e) {
      print(e.response);
      emit(GetItemDataFailed());
      loading = false;
    }
  }
}
