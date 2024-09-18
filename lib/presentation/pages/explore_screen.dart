import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_state.dart';
import 'package:elconnected/presentation/blocs/MainLayerNavCubit/main_layer_navigaton_cubit.dart';
import 'package:elconnected/presentation/widgets/search_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDataCubit, HomeDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              top: Device.deviceStatusBar(context: context) + 10),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(top: 0),
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () =>
                          MainLayerNavigationCubit.get(context).navigate(1),
                      child: AbsorbPointer(
                        child: Row(
                          children: [
                            SearchField(
                              hintText: LocaleKeys.whatareyoulookingfor.tr(),
                              suffixIcon: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: SvgPicture.asset(
                                  "assets/images/Group 1000002766.svg",
                                ),
                              ),
                            ),
                            const Gap(8),
                            // BlocProvider(
                            //   create: (context) => SubCatergoriesCubit(),
                            //   child: const FilterIcon(),
                            // ),
                            // const Gap(16)
                          ],
                        ),
                      ),
                    ),
                    const Gap(16),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: HomeDataCubit.get(context).allExploreItems,
              ),
              const Gap(40)
            ],
          ),
        );
      },
    );
  }
}
/*
Column(
                    children: [
                      HomeDataCubit.get(context).hotDeals == null
                          ? const SizedBox()
                          : RowTextLabel(
                              label:
                                  "${LocaleKeys.nEW.tr()} ${LocaleKeys.arrivals.tr()}"),
                      HomeDataCubit.get(context).hotDeals == null
                          ? const SizedBox()
                          : const Gap(16),
                      HomeDataCubit.get(context).hotDeals == null
                          ? const SizedBox()
                          : AppHorizintalScrollList(
                              itemsShow: HomeDataCubit.get(context)
                                      .hotDeals!
                                      .result!
                                      .collections!
                                      .items![0]
                                      .items ??
                                  [],
                            ),
                    ],
                  )
HomeDataCubit.get(context).hotDeals == null
                ? const SizedBox()
                : const Gap(40),
            HomeDataCubit.get(context).hotDeals == null
                ? const SizedBox()
                : HotDealsBox(
                    allitems: HomeDataCubit.get(context)
                        .hotDeals!
                        .result!
                        .collections!
                        .items![0]
                        .items!,
                  ),

 HomeDataCubit.get(context).hotDeals == null
                ? const SizedBox()
                : Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 40, start: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RowTextLabel(
                            label: LocaleKeys.vehiclesbestsellers.tr()),
                        const Gap(16),
                        AppHorizintalScrollList(
                          itemsShow: HomeDataCubit.get(context)
                              .hotDeals!
                              .result!
                              .collections!
                              .items![0]
                              .items!,
                        ),
                      ],
                    ),
                  ),
                  HomeDataCubit.get(context).hotDeals == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    padding: const EdgeInsetsDirectional.only(
                        top: 16, start: 16, bottom: 16),
                    color: const Color.fromRGBO(241, 241, 253, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RowTextLabel(label: LocaleKeys.lifestylePicks.tr()),
                        const Gap(16),
                        AppHorizintalScrollList(
                          itemImage:
                              "assets/images/Screenshot_2024-04-22_at_12.14 1.png",
                          itemsShow: HomeDataCubit.get(context)
                              .hotDeals!
                              .result!
                              .collections!
                              .items![0]
                              .items!,
                        ),
                      ],
                    ),
                  )
*/