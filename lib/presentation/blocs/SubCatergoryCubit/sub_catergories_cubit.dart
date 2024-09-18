import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/category_product_model.dart';
import 'package:elconnected/domain/use_cases/wishlist_items.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCatergoriesCubit extends Cubit<SubCatergoriesState> {
  SubCatergoriesCubit() : super(SubCatergoriesInitial());
  static SubCatergoriesCubit get(context) => BlocProvider.of(context);
  CategoryProductModel? categoryItems;
  List<ItemsINCategory> allItems = [];
  List<ItemsINCategory> tempList = [];
  bool filterd = false;
  final dio = Dio();
  int skipitems = 0;
  bool loading = false;
  getCategoryData(String id, bool scroll) async {
    emit(GetSubLoadingState());
    scroll ? null : loading = true;

    try {
      // await getSubCatergory(id: id);
      await getItems(id: id);
      loading = false;
      emit(GetSubDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      categoryItems = null;
      emit(GetSubFailedState());
    }
  }

  getSubCatergory({required String id}) async {
    final response = await dio.get(
        "${ApiConstant.baseUrl}/mobile/api/categories/$id/subcategories",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    print(response.data);
  }

  getItems({required String id, String? api}) async {
    final response = await dio.get(
        api ??
            "${ApiConstant.baseUrl}/mobile/api/items?CategoryId=$id&SkipCount=$skipitems&MaxResultCount=10",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    categoryItems = CategoryProductModel.fromJson(response.data);
    print(categoryItems?.result?.items?.items ?? []);
    allItems += categoryItems?.result?.items?.items ?? [];
  }

  scroll(String id) {
    skipitems += 10;
    getCategoryData(id, true);
    emit(ItemsScrollState());
  }

  searchItems({required String id, required String keyWord}) async {
    emit(GetSearchLoadingState());
    tempList.isEmpty ? tempList = allItems : null;
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/items?CategoryId=$id&SearchKeyword=$keyWord&SkipCount=$skipitems&MaxResultCount=20",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      categoryItems = CategoryProductModel.fromJson(response.data);
      print(categoryItems?.result?.items?.items ?? []);
      allItems = categoryItems?.result?.items?.items ?? [];
      emit(GetSearchDoneState());
    } on DioException catch (e) {
      print(e.response);
      emit(GetSearchFailedState());
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

  resetSearch() {
    allItems = tempList;
    tempList = [];
    filterd = false;
    emit(ResetSearchState());
  }

  filterSearch(List<String> filters, String catId) async {
    filterd ? null : tempList = allItems;
    loading = true;
    emit(FilterItemsLoadingState());
    String api =
        "${ApiConstant.baseUrl}/mobile/api/items?CategoryId=$catId&SkipCount=$skipitems&MaxResultCount=20";
    int proPnum = 1;
    for (var element in filters) {
      api += "&additionalProp$proPnum=$element";
      print(api);
      proPnum++;
    }
    try {
      await getItems(id: catId, api: api);
      loading = false;
      filterd = true;
      emit(FilterItemsDoneState());
    } on DioException catch (e) {
      loading = false;
      print(e.response);
      emit(FilterItemsFailedState());
    }
  }
}
//&additionalProp1=string&additionalProp2=string&additionalProp3=string