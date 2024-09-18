import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/sellitem_model.dart';
import 'package:elconnected/domain/use_cases/filter_search.dart';
import 'package:elconnected/presentation/blocs/FilterCubit/filter_state.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_state.dart';
import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitialState());
  static FilterCubit get(context) => BlocProvider.of(context);
  String typeFilter = "All";
  String areaFilter = "All";
  SellitemModel? sellSpecifications;
  List<Specifications> detailsList = [];
  bool customSelection = false;
  String customFilterType = LocaleKeys.amenities.tr();

  List<Widget> allfilterswid = [
    BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Row(
          children: [
            Text(LocaleKeys.filters.tr(),
                style: const TextStyle(color: Colors.black, fontSize: 22)),
            const Spacer(),
            FilterSearch.filters.isEmpty
                ? const SizedBox()
                : BlocConsumer<SubCatergoriesCubit, SubCatergoriesState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            FilterCubit.get(context).clearAllFilters();
                            SubCatergoriesCubit.get(context).resetSearch();
                          },
                          child: Text(
                            LocaleKeys.clearall.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.red),
                          ));
                    },
                  ),
            Container(
              decoration: BoxDecoration(
                  color: AppThemeData.appBlue,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(FilterSearch.filters.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 22)),
            )
          ],
        );
      },
    ),
    const Gap(20),
    const SizedBox(
      width: double.infinity,
    )
  ];
  selectType(String type) {
    typeFilter = type;
    emit(TypeFilterState());
  }

  clearAllFilters() {
    FilterSearch.clearFilter();

    emit(ClearAllState());
  }

  selectArea(String area) {
    areaFilter = area;
    emit(AreaFilterState());
  }

  switchToCustomSelection() {
    customSelection = !customSelection;
    emit(CustomSelectionState());
  }

  addCustomFilter(String filter) {
    FilterSearch.addFilter(filter);
    emit(CustomFilterState());
  }

  getSellRequirement(String id, BuildContext context) async {
    emit(GetFilterLoadingState());
    final dio = Dio();
    try {
      final response = await dio.get(
          "${ApiConstant.baseUrl}/mobile/api/categories/$id/specifications",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': LocalePref.prefs!.getString("token")
          }));
      sellSpecifications = SellitemModel.fromJson(response.data);
      print("++++++++++++++++++++++++++++++++++++++++++");
      print(response.data);
      print("++++++++++++++++++++++++++++++++++++++++++");
      detailsList = sellSpecifications?.result?.specifications ?? [];
      allfilterswid += List.generate(
        detailsList.length,
        (index) {
          return BlocConsumer<FilterCubit, FilterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(detailsList[index].name ?? '',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Gap(16),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      detailsList[index].values?.length ?? 0,
                      (z) => RoundedCardWithText(
                          ontap: () {
                            addCustomFilter(
                                detailsList[index].values?[z].id ?? '');
                          },
                          backgroundColor: FilterSearch.filters
                                  .contains(detailsList[index].values?[z].id)
                              ? AppThemeData.appBlue
                              : null,
                          borderColor: FilterSearch.filters
                                  .contains(detailsList[index].values?[z].id)
                              ? null
                              : Colors.grey.withOpacity(0.4),
                          textColor: FilterSearch.filters
                                  .contains(detailsList[index].values?[z].id)
                              ? Colors.black
                              : Colors.black,
                          cardText:
                              detailsList[index].values?[z].value ?? 'xx'),
                    ),
                  ),
                  const Gap(30)
                ],
              );
            },
          );
        },
      ).toList();
      emit(GetFilterDoneState());
    } on DioException catch (e) {
      print(e.response);
      emit(GetFilterFailedState());
    }
  }
}
