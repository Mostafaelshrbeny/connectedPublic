import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/category_product_model.dart';
import 'package:elconnected/presentation/blocs/SectionDataCubit/sections_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionsDataCubit extends Cubit<SectionsDataState> {
  SectionsDataCubit() : super(SectionsDataInitial());
  static SectionsDataCubit get(context) => BlocProvider.of(context);
  int skipitems = 0;
  bool loading = false;
  CategoryProductModel? allItems;
  List<ItemsINCategory> itemList = [];
  getSectionData(int id) async {
    final dio = Dio();
    emit(SectionLoadingState());
    loading = true;
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/items?CollectionId=$id&SkipCount=$skipitems&MaxResultCount=10",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      allItems = CategoryProductModel.fromJson(response.data);

      itemList += allItems?.result?.items?.items ?? [];
      loading = false;
      emit(SectionDoneState());
    } on DioException catch (e) {
      print(e.response);
      loading = false;
      emit(SectionFailedState());
    }
  }

  scroll(int id) {
    skipitems += 10;
    getSectionData(id);
    emit(SectionScrollState());
  }
}
