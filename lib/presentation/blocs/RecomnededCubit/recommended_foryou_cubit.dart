import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/collection_model.dart';
import 'package:elconnected/data/models/recommended_model.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/RecomnededCubit/recommended_foryou_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedForyouCubit extends Cubit<RecommendedForyouState> {
  RecommendedForyouCubit() : super(RecommendedForyouInitial());
  static RecommendedForyouCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  final dio = Dio();
  RecommendedItemsModel? recommendedforItems;
  List<ItemsIn> items = [];
  int skipItems = 0;

  getRecommended(int skip) async {
    emit(RecommendedLoadingState());
    loading = true;
    try {
      final response = await dio.get(
          '${ApiConstant.baseUrl}/mobile/api/items/recommended?SkipCount=$skip&MaxResultCount=10',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      recommendedforItems = RecommendedItemsModel.fromJson(response.data);
      items += recommendedforItems?.result?.items?.items ?? [];
      loading = false;
      print(
          "++++++++++++++++++++++++++++++$skip+++++++++++++++++++++++++++++++++");
      print(recommendedforItems?.result?.items?.items ?? []);
      emit(RecommendedDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(RecommendedFailedState());
    }
  }

  scroll() {
    skipItems += 10;
    getRecommended(skipItems);
    emit(RecommendedScrollState());
  }

  addtoList(int id) {
    ItemActions.addItem(id);
    emit(LikeItemDone());
  }

  likeProduct(int id) async {
    try {
      await dio.post("${ApiConstant.baseUrl}/mobile/api/items/$id/wishlist",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }),
          data: {});
      emit(LikeItemDone());
    } on DioException catch (e) {
      print(e.response);
      emit(LikeItemFailed());
    }
  }
}
