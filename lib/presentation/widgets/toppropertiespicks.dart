import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/data/models/collection_model.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopPropertiesPicks extends StatelessWidget {
  const TopPropertiesPicks({
    super.key,
    required this.topPicksItems,
  });
  final List<ItemsIn> topPicksItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.topPropertiesPicks.tr(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Gap(16),
          ListView.separated(
            padding: const EdgeInsets.all(0),
            separatorBuilder: (context, index) => const Gap(8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => SizedBox(
              height: Device.deviceHeight(context: context, percent: 1 / 4),
              child: AppProductItem(
                itemWidth: double.infinity,
                image: topPicksItems[index].thumbnailUrl!,
                name: topPicksItems[index].name!,
                price: topPicksItems[index].price.toString(),
                id: topPicksItems[index].id!,
              ),
            ),
            itemCount: topPicksItems.length <= 2 ? topPicksItems.length : 2,
          ),
          const Gap(24),
          AppCustomButton(
            buttonChild: Text(
              LocaleKeys.findmoreProperties.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppThemeData.appBlue),
            ),
            ontap: () {},
            borderColor: AppThemeData.appBlue,
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
