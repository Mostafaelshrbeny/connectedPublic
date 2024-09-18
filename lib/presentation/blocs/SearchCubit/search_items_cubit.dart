import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/category_product_model.dart';
import 'package:elconnected/data/models/recentsearch_model.dart';
import 'package:elconnected/data/models/search_result_model.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchItemsCubit extends Cubit<SearchItemsState> {
  SearchItemsCubit() : super(SearchItemsInitial());
  static SearchItemsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchCon = TextEditingController();
  bool loading = false;
  final dio = Dio();
  bool searching = false;
  SearchResultModel? result;
  List<ItemsINCategory> searchList = [];
  RecentSearchModel? recentSearch;
  getRecent() async {
    emit(GetRecentLoadingState());
    loading = true;
    try {
      final response =
          await dio.get(ApiConstant.baseUrl + ApiConstant.recentSearch,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': LocalePref.prefs!.getString("token")
              }));
      recentSearch = RecentSearchModel.fromJson(response.data);
      loading = false;
      print(response.data);

      emit(GetRecentDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(GetRecentFailedState());
    }
  }

  searchItem({required String keywords}) async {
    searching = true;
    emit(SearchLoadingState());

    if (keywords.isEmpty || keywords == '') {
      resetSearch();
      loading = false;
    } else {
      try {
        final response = await dio.get(
            "${ApiConstant.baseUrl}/mobile/api/items?SearchKeyword=$keywords&SkipCount=0&MaxResultCount=20",
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Authorization': LocalePref.prefs!.getString("token")
            }));
        result = SearchResultModel.fromJson(response.data);
        searchList = result?.result?.items?.items ?? [];
        searching = false;
        emit(SearchDoneState());
      } on DioException catch (e) {
        print(e.response);
        searching = false;
        emit(SearchFailedState());
      }
    }
  }

  resetSearch() {
    searchList = [];
    emit(SearchResetState());
  }

  setSearch(String recent) {
    searchCon.text = recent;
    emit(SearchDoneState());
  }
}
