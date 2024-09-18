import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/appconstant.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/sign_in_later_dialog.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_cubit.dart';
import 'package:elconnected/presentation/blocs/SubCatergoryCubit/sub_catergories_state.dart';

import 'package:elconnected/presentation/widgets/exploreour_text.dart';
import 'package:elconnected/presentation/widgets/filtericon.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:elconnected/presentation/widgets/search_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CategoryPresentList extends StatelessWidget {
  const CategoryPresentList({
    super.key,
    required this.name,
    required this.controller,
    required this.id,
  });
  final String name;
  final ScrollController controller;
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatergoriesCubit, SubCatergoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var itemsCubit = SubCatergoriesCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(
              top: Device.deviceStatusBar(context: context) + 10),
          child: ListView(
            controller: controller,
            //  physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(start: 16, top: 0),
            shrinkWrap: true,
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.2),
                            child: const Icon(Icons.arrow_back),
                          )),
                      SearchField(
                        onSearch: (p0) {
                          p0 == null || p0.isEmpty
                              ? itemsCubit.resetSearch()
                              : itemsCubit.searchItems(
                                  id: id, keyWord: p0.toLowerCase());
                        },
                        hintText: "Search ${name}",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: BlocProvider.value(
                            value: SubCatergoriesCubit.get(context),
                            child: FilterIcon(
                              id: id,
                            ),
                          ),
                        ),
                      )
                    ],
                  )

                  //SearchRow(),
                  ),
              Gap(Device.deviceHeight(context: context, percent: 1 / 22)),
              ExploreOurCollectionText(
                name: name,
              ),
              Gap(Device.deviceHeight(context: context, percent: 1 / 22)),
              SizedBox(
                height: Device.deviceHeight(
                    context: context,
                    percent: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 1 / 22
                        : 1 / 10),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => RoundedCardWithText(
                        cardRaduis: 30,
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                        cardText: AppConstant.rowFilterNames[index]),
                    separatorBuilder: (context, index) => const Gap(8),
                    itemCount: 1),
              ),
              const Gap(8),
              itemsCubit.loading
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Device.deviceHeight(
                              context: context, percent: 1 / 10)),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppThemeData.appBlue,
                        ),
                      ),
                    )
                  : itemsCubit.categoryItems == null ||
                          itemsCubit.allItems.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Device.deviceHeight(
                                  context: context, percent: 1 / 10)),
                          child: Center(
                            child: Text(
                              LocaleKeys.noItems.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: AppThemeData.appBlue),
                            ),
                          ),
                        )
                      : SizedBox(
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsetsDirectional.only(end: 16),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 0.7
                                            : 0.6,
                                    crossAxisSpacing: 15,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15),
                            itemBuilder: (context, index) => AppProductItem(
                              onlike: () => HiveLocaleData.myAppBox
                                      ?.get('notuser')
                                  ? SignInLaterDialog.signInDialog(
                                      context, () {})
                                  : (
                                      SubCatergoriesCubit.get(context).like(
                                          int.parse(
                                              itemsCubit.allItems[index].id ??
                                                  "0")),
                                      SubCatergoriesCubit.get(context)
                                          .likeProduct(int.parse(
                                              itemsCubit.allItems[index].id ??
                                                  "0"))
                                    ),
                              loveWithPadding: false,
                              image:
                                  itemsCubit.allItems[index].thumbnailUrl ?? "",
                              name: itemsCubit.allItems[index].name ?? "",
                              price: itemsCubit.allItems[index].price ?? '',
                              id: itemsCubit.allItems[index].id ?? "0",
                            ),
                            itemCount: itemsCubit.allItems.length,
                          ),
                        )
            ],
          ),
        );
      },
    );
  }
}
