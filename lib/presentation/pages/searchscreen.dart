import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/HomeCubit/home_data_cubit.dart';
import 'package:elconnected/presentation/blocs/MerchantsCubit/merchants_data_cubit.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_cubit.dart';
import 'package:elconnected/presentation/blocs/SearchCubit/search_items_state.dart';
import 'package:elconnected/presentation/pages/allmerchants_screen.dart';
import 'package:elconnected/presentation/widgets/allcatergories.dart';
import 'package:elconnected/presentation/widgets/homemercahant_list.dart';
import 'package:elconnected/presentation/widgets/popular_searches.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:elconnected/presentation/widgets/recomendedforyou.dart';
import 'package:elconnected/presentation/widgets/search_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((val) => SearchItemsCubit.get(context).getRecent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchItemsCubit, SearchItemsState>(
      listener: (context, state) {
        if (state is SearchDoneState &&
            SearchItemsCubit.get(context).searchList.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(LocaleKeys.noItems.tr())));
        } else if (state is SearchResetState) {
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              top: Device.deviceStatusBar(context: context) + 10),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(start: 16, top: 0),
            children: [
              Row(
                children: [
                  SearchField(
                      con: SearchItemsCubit.get(context).searchCon,
                      onSearch: (p0) {
                        p0 == null || p0.isEmpty
                            ? SearchItemsCubit.get(context).resetSearch()
                            : SearchItemsCubit.get(context)
                                .searchItem(keywords: p0);
                      },
                      hintText: LocaleKeys.whatareyoulookingfor.tr(),
                      suffixIcon: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: SvgPicture.asset(
                          "assets/images/Group 1000002766.svg",
                        ),
                      )),
                  const Gap(8),
                ],
              ),
              const Gap(12),
              SearchItemsCubit.get(context).searching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppThemeData.appBlue,
                      ),
                    )
                  : SearchItemsCubit.get(context).searchList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 2.5),
                          itemBuilder: (context, index) => AppProductItem(
                            loveWithPadding: true,
                            image: SearchItemsCubit.get(context)
                                    .searchList[index]
                                    .thumbnailUrl ??
                                '',
                            name: SearchItemsCubit.get(context)
                                    .searchList[index]
                                    .name ??
                                "",
                            price: SearchItemsCubit.get(context)
                                .searchList[index]
                                .price
                                .toString(),
                            id: SearchItemsCubit.get(context)
                                .searchList[index]
                                .id!,
                          ),
                          itemCount:
                              SearchItemsCubit.get(context).searchList.length,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchItemsCubit.get(context).recentSearch == null
                                ? const SizedBox()
                                : Text(
                                    LocaleKeys.popularsearches.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                            Gap(10),
                            SearchItemsCubit.get(context).recentSearch == null
                                ? const SizedBox()
                                : PopularSearches(),
                            const Gap(24),
                            Text(LocaleKeys.categories.tr(),
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const Gap(10),
                            const AllCatergoriesPresent(
                              cardBackground: Color.fromRGBO(241, 241, 253, 1),
                            ),
                            const Gap(32),
                            HomeDataCubit.get(context).merchants == null
                                ? const SizedBox()
                                : RowTextLabel(
                                    label: LocaleKeys.featuredmerchants.tr(),
                                    ontap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (context) =>
                                                      MerchantsDataCubit(),
                                                  child:
                                                      const AllmerchantsScreen(),
                                                ))),
                                  ),
                            HomeDataCubit.get(context).merchants == null
                                ? const SizedBox()
                                : const MerchantList(),
                            const Gap(32),
                          ],
                        ),
            ],
          ),
        );
      },
    );
  }
}
