import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/api_constant.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_cubit.dart';
import 'package:elconnected/presentation/pages/appgrid_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MyListingCard extends StatelessWidget {
  const MyListingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => ItemsInGridCubit(),
              child: GridListScreens(
                arguments: {
                  "title": LocaleKeys.myListings.tr(),
                  "api": ApiConstant.wishLists
                },
              ),
            ),
          )),
      child: Container(
        padding:
            const EdgeInsetsDirectional.only(top: 12, bottom: 12, start: 12),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(212, 252, 0, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.assignment, color: Colors.black),
                const Gap(4),
                Text(
                  LocaleKeys.myListings.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
            const Gap(15),
            Container(
              padding: EdgeInsetsDirectional.only(
                  top: 4,
                  bottom: 4,
                  start: 4,
                  end: HiveLocaleData.myAppBox?.get("pend") == "0" ||
                          HiveLocaleData.myAppBox?.get("pend") == ""
                      ? 4
                      : 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromRGBO(212, 252, 0, 1),
                    radius: 17.5,
                    child: Text(HiveLocaleData.myAppBox?.get("totalnum") ?? "0",
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  HiveLocaleData.myAppBox?.get("pend") == "0" ||
                          HiveLocaleData.myAppBox?.get("pend") == ""
                      ? const SizedBox()
                      : const Gap(8),
                  HiveLocaleData.myAppBox?.get("pend") == "0" ||
                          HiveLocaleData.myAppBox?.get("pend") == ""
                      ? const SizedBox()
                      : Text(HiveLocaleData.myAppBox?.get("pend") ?? "0",
                          style: Theme.of(context).textTheme.headlineMedium)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
