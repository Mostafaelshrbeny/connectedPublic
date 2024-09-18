import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/presentation/blocs/ItemsGridCubit/items_in_grid_cubit.dart';
import 'package:elconnected/presentation/pages/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({
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
              child: WishListScreen(
                arguments: {
                  "title": LocaleKeys.wishlist.tr(),
                },
              ),
            ),
          )),
      child: Container(
        padding:
            const EdgeInsetsDirectional.only(top: 12, bottom: 12, start: 12),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(186, 186, 245, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // const Icon(Icons.heart_broken_rounded, color: Colors.black),
                const FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.black,
                  size: 20,
                ),
                const Gap(4),
                Expanded(
                  child: Text(
                    LocaleKeys.wishlist.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 2,
                  ),
                )
              ],
            ),
            const Gap(15),
            CircleAvatar(
              radius: 21.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(186, 186, 245, 1),
                radius: 17.5,
                child: Text(HiveLocaleData.myAppBox!.get("wishnum") ?? '',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            )
          ],
        ),
      ),
    );
  }
}
