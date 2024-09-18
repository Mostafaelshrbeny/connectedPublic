import 'package:dio/dio.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/data/models/collection_model.dart';
import 'package:elconnected/data/models/explore_collection_model.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/SectionDataCubit/sections_data_cubit.dart';
import 'package:elconnected/presentation/pages/sctions_screen.dart';
import 'package:elconnected/presentation/widgets/apphorizintalscroll.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/recomendedforyou.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ExploreCollections {
  static final dio = Dio();
  static getHotDeals() async {
    final response = await dio.get(
        "${ApiConstant.baseUrl}/mobile/api/collections?IsInHome=false&ShouldIncludeItems=true&TotalIncludeItems=4",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': LocalePref.prefs!.getString("token")
        }));
    return ExploreCollectionModel.fromJson(response.data);
  }

  static generateWidget(
      ExploreCollectionModel? hotDeals, BuildContext context) {
    print("++++++++++++++++++++++++555555555555555555555555++++++++++++++++++");
    print(hotDeals?.result?.collections?.items?[0].id);
    return List.generate(
        hotDeals?.result?.collections?.items?.length ?? 0,
        (index) => Container(
              padding: const EdgeInsets.all(16),
              color: hexToColor(hotDeals?.result?.collections?.items?[index]
                      .backgroundColorCode ??
                  '#FFFF00'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hotDeals?.result?.collections?.items?[index].type ==
                          "HorizontalList"
                      ? RowTextLabel(
                          endPadding: false,
                          ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            SectionsDataCubit(),
                                        child: SctionsScreen(
                                          id: hotDeals?.result?.collections
                                                  ?.items?[index].id ??
                                              0,
                                          name: hotDeals?.result?.collections
                                                  ?.items?[index].name ??
                                              "",
                                        ),
                                      ))),
                          label:
                              "${hotDeals?.result?.collections?.items?[index].name ?? ''}  ${hotDeals?.result?.collections?.items?[index].mainEmoji ?? ''}")
                      : Text(
                          "${hotDeals?.result?.collections?.items?[index].name ?? ''}  ${hotDeals?.result?.collections?.items?[index].mainEmoji ?? ''}",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                  const Gap(20),
                  selectItemPresent(
                      show: hotDeals?.result?.collections?.items?[index].type ??
                          "HorizontalList",
                      allitems:
                          hotDeals?.result?.collections?.items?[index].items ??
                              []),
                  const Gap(10),
                  hotDeals?.result?.collections?.items?[index].type ==
                          "HorizontalList"
                      ? const SizedBox()
                      : AppCustomButton(
                          backgroundColor: hexToColor(hotDeals
                                  ?.result
                                  ?.collections
                                  ?.items?[index]
                                  .actionButton
                                  ?.backgroundColor ??
                              '#0000FF'),
                          buttonChild: Text(
                            hotDeals?.result?.collections?.items?[index]
                                    .actionButton?.name ??
                                "",
                            style: TextStyle(
                                color: hexToColor(hotDeals
                                        ?.result
                                        ?.collections
                                        ?.items?[index]
                                        .actionButton
                                        ?.textColor ??
                                    "#FFFFFF")),
                          ),
                          ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            SectionsDataCubit(),
                                        child: SctionsScreen(
                                          id: hotDeals?.result?.collections
                                                  ?.items?[index].id ??
                                              0,
                                          name: hotDeals?.result?.collections
                                                  ?.items?[index].name ??
                                              "",
                                        ),
                                      ))))
                ],
              ),
            )).toList();
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static selectItemPresent(
      {required String show, required List<ItemsIn> allitems}) {
    switch (show) {
      case "Grid":
        return ExploreGridItems(allitems: allitems);
      case "HorizontalList":
        return AppHorizintalScrollList(itemsShow: allitems);
      default:
        return const SizedBox();
    }
  }
}
