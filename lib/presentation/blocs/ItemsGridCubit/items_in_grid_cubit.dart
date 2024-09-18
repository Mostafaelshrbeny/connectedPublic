import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/grid_items_model.dart';
import 'package:elconnected/data/models/wishlist_model.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsInGridCubit extends Cubit<ItemsInGridState> {
  ItemsInGridCubit() : super(ItemsInGridInitial());
  static ItemsInGridCubit get(context) => BlocProvider.of(context);
  GridItemsModel? gridItemsList;
  List<Items> items = [];
  WishListModel? wishItems;
  bool loading = false;
  getData({required String dataApi}) async {
    emit(GetItemsInGridLoadingState());
    final dio = Dio();
    loading = true;
    try {
      final response = await dio.get(ApiConstant.baseUrl + dataApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      gridItemsList = GridItemsModel.fromJson(response.data);
      print(gridItemsList);
      loading = false;
      itemsList(api: dataApi);
      emit(GetItemsInGridDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      emit(GetItemsInGridFailedState());
    }
  }

  getWishList() async {
    emit(GetItemsInGridLoadingState());
    final dio = Dio();
    loading = true;
    try {
      final response =
          await dio.get(ApiConstant.baseUrl + ApiConstant.wishLists,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }));
      wishItems = WishListModel.fromJson(response.data);
      if (wishItems?.result == null ||
          wishItems?.result!.wishlistItems == null) {
        wishItems = null;
      }
      print(gridItemsList);
      loading = false;

      emit(GetItemsInGridDoneState());
    } on DioException catch (e) {
      print(e.response!.data);
      loading = false;
      emit(GetItemsInGridFailedState());
    }
  }

  itemsList({required String api}) {
    switch (api) {
      case ApiConstant.recentView:
        items = gridItemsList?.result?.recentlyViewedItems?.items ?? [];
        break;
      case ApiConstant.sharedItems:
        items = gridItemsList?.result?.sharedItems?.items ?? [];
        break;
      default:
        items = [];
    }
  }
}
